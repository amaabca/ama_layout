shared_examples 'member_navigation' do

  context 'overview' do
    it 'has the correct overview text and url' do
      expect(subject.items[0].text).to eq 'My Account Overview'
      expect(subject.items[0].link).to eq "#{gatekeeper_site}/"
    end
  end

  context "membership" do
    let(:membership_subnav) { subject.items[1].sub_nav }

    it "returns the subnav items" do
      length = membership_subnav.length

      expect(membership_subnav[0].text).to eq 'Membership Overview'
      expect(membership_subnav[0].link).to eq "#{membership_site}/membership/overview"

      expect(membership_subnav[length - 3].text).to eq 'Manage Membership'
      expect(membership_subnav[length - 3].link).to eq "#{membership_site}/membership/manage"

      expect(membership_subnav[length - 2].text).to eq 'Billing Options'
      expect(membership_subnav[length - 2].link).to eq "#{youraccount_site}/billing"

      expect(membership_subnav.last.text).to eq 'Print/Request New Card'
      expect(membership_subnav.last.link).to eq "#{youraccount_site}/membership"
    end
  end

  context 'automotive' do
    let(:automotive_subnav) { subject.items[2].sub_nav }

    it 'returns the subnav items' do
      expect(automotive_subnav[0].text).to eq 'Roadside Assistance Overview'
      expect(automotive_subnav[0].link).to eq "#{automotive_site}/"
    end
  end

  context 'driver education' do
    let(:driver_education_subnav) { subject.items[3].sub_nav }

    it 'return the subnav items' do
      expect(driver_education_subnav[0].text).to eq 'Driver Education Overview'
      expect(driver_education_subnav[0].link).to eq "#{driveredonline_site}/"

      expect(driver_education_subnav[1].text).to eq 'New Driver Online Program'
      expect(driver_education_subnav[1].link).to eq "#{driveredonline_site}/dashboard"
    end
  end

  context 'rewards' do
    let(:rewards_subnav) { subject.items[4].sub_nav }

    it 'returns the subnav items' do
      expect(rewards_subnav[0].text).to eq 'Rewards Overview'
      expect(rewards_subnav[0].link).to eq "#{youraccount_site}/rewards"

      expect(rewards_subnav[1].text).to eq 'Gift Cards'
      expect(rewards_subnav[1].link).to eq "#{membership_site}/reward_cards"

      expect(rewards_subnav[2].text).to eq 'Transaction History'
      expect(rewards_subnav[2].link).to eq "#{youraccount_site}/reward_dollars"

      expect(rewards_subnav[3].text).to eq 'Pizza 73 Coupon Codes'
      expect(rewards_subnav[3].link).to eq "#{youraccount_site}/pizza73"
    end
  end

  context 'registries' do
    let(:registries_subnav) { subject.items[5].sub_nav }

    it 'returns the subnav items' do
      expect(registries_subnav[0].text).to eq 'Registries Overview'
      expect(registries_subnav[0].link).to eq "#{registries_site}/"

      expect(registries_subnav[1].text).to eq 'Vehicle Registration Auto-Renew'
      expect(registries_subnav[1].link).to eq "#{registries_site}/order/registrations/new"
    end
  end

  context 'travel' do
    it 'has the correct travel text and url' do
      expect(subject.items[6].text).to eq 'My Travel'
      expect(subject.items[6].link).to eq "#{travel_login_url}"
    end
  end

  context 'my account' do
    let(:my_account_subnav) { subject.items[7].sub_nav }

    it 'returns the subnav items' do
      expect(my_account_subnav[0].text).to eq 'Change Email/Password'
      expect(my_account_subnav[0].link).to eq "#{gatekeeper_site}/user/edit"

      expect(my_account_subnav[1].text).to eq 'Email Subscriptions'
      expect(my_account_subnav[1].link).to eq "#{youraccount_site}/subscriptions"

      expect(my_account_subnav[2].text).to eq 'AMA Insider Magazine'
      expect(my_account_subnav[2].link).to eq "#{youraccount_site}/amainsider"

      expect(my_account_subnav[3].text).to eq 'Change Address'
      expect(my_account_subnav[3].link).to eq "#{youraccount_site}/membership_update/new"
    end
  end
end
