# frozen_string_literal: true

describe AmaLayoutContentHelper do
  let(:greeting) { 'DJ Funky Fresh' }
  let(:site_name) { 'Waffle Emporium' }
  let(:site_domain) { 'http://waffleemporium.ca' }
  let(:site_url) { "#{site_domain}/wafflesauce" }
  let(:nav_item) { FactoryBot.build(:navigation_item) }

  describe '#greeting' do
    it 'returns the greeting set in the domain cookie' do
      helper.request.cookies[:logged_in_meta] = greeting
      expect(helper.greeting).to eq greeting
    end
  end

  describe '#utm_source' do
    it 'returns the downcased character-only representation of the site name' do
      allow(Rails.configuration).to receive(:site_name).and_return(site_name)
      expect(helper.utm_source).to eq site_name.downcase.gsub(/\W/, '')
    end
  end

  describe '#active_section' do
    it 'returns active if request include the path' do
      allow_any_instance_of(ActionController::TestRequest).to receive(:fullpath).and_return("#{site_domain}/gotica")
      expect(helper.active_section(nav_item)).to eq 'activepage'
    end

    it 'returns nil if request  does not include the path' do
      expect(helper.active_section(nav_item)).to eq nil
    end
  end

  describe '#active_page' do
    before(:each) do
      allow(helper.request).to receive(:fullpath).and_return(site_url)
    end

    it 'returns active if the given path matches the request path' do
      expect(helper.active_page(site_url)).to eq 'activepage'
    end

    it 'returns nothing if the given patch does not match the request path' do
      expect(helper.active_page('http://waffleemporium.ca/ecuaselffaw')).to be_nil
    end
  end

  describe '#active_domain' do
    before(:each) do
      allow(helper.request).to receive(:url).and_return(site_url)
    end

    it 'returns active if the request domain matches the given domain' do
      expect(helper.active_domain(site_domain)).to eq 'active'
    end

    it 'returns nothing if the request domain does not match the given domain' do
      expect(helper.active_domain('http://pancakeemporium.ca')).to be_nil
    end
  end

  describe '#renew_or_join_path' do
    it 'returns nothing if the visitor is logged in' do
      expect(helper.renew_or_join_path(true)).to eq ''
    end

    it 'returns the join link if the visitor is not logged in' do
      expect(helper.renew_or_join_path(false)).to include 'Become a Member'
    end
  end

  describe '#gift_or_pricing_path' do
    it 'returns nothing if the visitor is logged in' do
      expect(helper.gift_or_pricing_path(true)).to eq ''
    end

    it 'returns the gift link if the visitor is not logged in' do
      expect(helper.gift_or_pricing_path(false)).to include 'Gift Membership'
    end
  end

  describe '#dropdown_menu' do
    let(:render_args) do
      { partial: 'ama_layout/v3/dropdown_menu', locals: { logged_in: true, greeting: greeting } }
    end

    it 'renders the dropdown menu if the visitor is logged in' do
      expect(helper).to receive(:render).with(render_args)
      helper.dropdown_menu(true, greeting)
    end

    it 'does not render the dropdown menu if the visitor is not logged in' do
      expect(helper.dropdown_menu(false, greeting)).to eq ''
    end
  end

  describe '#tablet_menu' do
    let(:render_args) do
      { partial: 'ama_layout/v3/tablet_menu', locals: { logged_in: true, greeting: greeting } }
    end

    it 'renders the tablet menu if the visitor is logged in' do
      expect(helper).to receive(:render).with(render_args)
      helper.tablet_menu(true, greeting)
    end

    it 'does not render the tablet menu if the visitor is not logged in' do
      expect(helper.tablet_menu(false, greeting)).to eq ''
    end
  end

  describe '#tablet_signout' do
    it 'renders a signout link if the visitor is logged in' do
      expect(helper).to receive(:render).with('ama_layout/v3/tablet_signout')
      helper.tablet_signout(true)
    end

    it 'does not render the tablet menu if the visitor is not logged in' do
      expect(helper.tablet_signout(false)).to eq ''
    end
  end

  describe '#notice' do
    let(:message) { 'This is a notice.' }

    it 'renders the notice partial if a notice is present' do
      expect(helper).to receive(:render).with partial: 'ama_layout/v3/notice', locals: { message: message }
      helper.notice(message)
    end

    it 'does not render the notice partial if a notice is not present' do
      expect(helper.notice(nil)).to be_nil
    end
  end

  describe '#alert' do
    let(:message) { 'This is an alert.' }

    it 'renders the alert partial if a alert is present' do
      expect(helper).to receive(:render).with partial: 'ama_layout/v3/alert', locals: { message: message }
      helper.alert(message)
    end

    it 'does not render the alert partial if a alert is not present' do
      expect(helper.notice(nil)).to be_nil
    end
  end

  describe '#success_message' do
    let(:message) { 'This is a success message' }

    it 'renders the success partial if a success message is present' do
      expect(helper).to receive(:render).with partial: 'ama_layout/v3/success', locals: { message: message }
      helper.success_message(message)
    end

    it 'does not render the success partial if the success message is not present' do
      expect(helper.success_message(nil)).to be_nil
    end
  end
end
