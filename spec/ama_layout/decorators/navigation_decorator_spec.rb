# frozen_string_literal: true

describe AmaLayout::NavigationDecorator do
  let(:user) { nil }
  let(:name) { nil }
  let(:navigation) { FactoryBot.build(:navigation, user: user, display_name: name) }
  subject { navigation.decorate }

  before(:each) do
    Rails.configuration.gatekeeper_site = 'http://auth.waffles.ca'
    Rails.configuration.youraccount_site = 'http://youraccount.waffles.ca'
    Rails.configuration.insurance_site = 'http://insurance.waffles.ca'
    Rails.configuration.membership_site = 'http://membership.waffles.ca'
    Rails.configuration.driveredonline_site = 'http://driveredonline.waffles.ca'
    Rails.configuration.registries_site = 'http://registries.waffles.ca'
    Rails.configuration.automotive_site = 'http://automotive.waffles.ca'
    Rails.configuration.travel_site = 'http://travel.waffles.ca'
    Rails.configuration.travel_login_url = 'http://travel.waffles.ca/MyAccount'
    Rails.configuration.amaabca_site = 'http://test.ama.ab.ca/'
  end

  describe '#display_name_text' do
    let(:user) { OpenStruct.new(email: 'john.doe@test.com') }

    context 'name is provided' do
      let(:name) { 'John D' }

      it 'has a welcome message' do
        expect(subject.display_name_text).to eq('Welcome, John D')
      end

      context 'long name given' do
        let(:name) { 'A Really Really Really Really Long Name' }

        it 'trucates to a total of 30 characters' do
          expect(subject.display_name_text).to eq("Welcome, #{name.titleize}".truncate(30))
        end
      end
    end

    context 'name is not provided' do
      it 'returns the email address' do
        expect(subject.display_name_text).to eq(user.email)
      end

      context 'a really long email' do
        let(:user) { OpenStruct.new(email: 'areallyreallyreallylongemail@test.com') }

        it 'trucates to a total of 30 characters' do
          expect(subject.display_name_text).to eq(user.email.truncate(30))
        end
      end
    end
  end

  describe '#items' do
    let(:user) { OpenStruct.new(navigation: 'member') }

    it 'returns an array of navigation items' do
      expect(subject.items).to be_an Array
    end

    it 'array contains decorated navigation items' do
      items = subject.items
      items.each do |i|
        expect(i).to be_a AmaLayout::NavigationItemDecorator
      end
    end
  end

  describe '#mobile_links' do
    context 'with user' do
      let(:user) { OpenStruct.new(email: 'john.doe@test.com') }

      it 'returns nil' do
        expect(subject.mobile_links).to eq('')
      end
    end

    context 'without user' do
      it 'renders an offcanvas menu' do
        expect(subject.mobile_links).to include('off-canvas')
      end
    end
  end

  describe '#sign_out_link' do
    context 'with user' do
      let(:user) { OpenStruct.new(navigation: 'member') }

      it 'returns link' do
        expect(subject.sign_out_link).to include('Sign Out')
      end
    end

    context 'without user' do
      it 'does not return the link' do
        expect(subject.sign_out_link).to eq('')
      end
    end
  end

  describe '#top_nav' do
    context 'with items' do
      let(:user) { OpenStruct.new(navigation: 'member') }

      it 'renders the partial' do
        expect(subject.top_nav).to include('has-submenu')
      end
    end

    context 'without items' do
      it 'does not renders the partial' do
        expect(subject.top_nav).to eq('')
      end
    end
  end

  describe '#sidebar' do
    context 'with items' do
      let(:user) { OpenStruct.new(navigation: 'member') }

      it 'renders the partial' do
        expect(subject.sidebar).to include('side-nav')
      end
    end

    context 'without items' do
      it 'does not render the partial' do
        expect(subject.sidebar).to eq('')
      end
    end
  end

  describe '#member_links' do
    let(:navigation) { FactoryBot.build(:navigation, user: user) }
    let(:member_links) { subject.member_links }

    context 'nil user' do
      let(:user) {}

      it 'returns nothing' do
        expect(member_links).to eq('')
      end
    end

    context 'non_member' do
      let(:user) { FactoryBot.build(:user, :non_member) }

      it 'returns nothing' do
        expect(member_links).to eq('')
      end
    end

    context 'status AL' do
      let(:user) { FactoryBot.build(:user, :in_renewal_late) }

      it 'returns nothing' do
        expect(member_links).to eq('')
      end
    end

    context 'outstanding balance' do
      let(:user) { FactoryBot.build(:user, :outstanding_balance) }

      it 'returns the manage credit cards link' do
        expect(member_links).to include('Manage Credit Cards')
      end
    end

    context 'member' do
      let(:user) { FactoryBot.build(:user) }

      it 'returns the manage credit cards link' do
        expect(member_links).to include('Manage Credit Cards')
      end
    end

    context 'in renewal' do
      let(:user) { FactoryBot.build(:user, :in_renewal) }

      it 'returns the manage credit cards link' do
        expect(member_links).to include('Manage Credit Cards')
      end
    end
  end

  context 'notification center' do
    let(:store) do
      AmaLayout::Notifications::RedisStore.new(
        db: 4,
        namespace: 'test_notifications',
        host: 'localhost'
      )
    end
    let(:notification_set) { AmaLayout::NotificationSet.new(store, 1) }
    let(:user) { OpenStruct.new(navigation: 'member', notifications: notification_set) }
    let(:navigation) { FactoryBot.build :navigation, user: user }
    subject { described_class.new(navigation) }

    around(:each) do |example|
      Timecop.freeze(Time.zone.local(2017, 6, 19)) do
        store.clear
        example.run
        store.clear
      end
    end

    describe '#notification_icon' do
      it 'renders the content to the page' do
        expect(subject.notification_icon).to include('data-notifications-toggle')
      end
    end

    describe '#mobile_notification_icon' do
      it 'renders the content to the page' do
        expect(subject.mobile_notification_icon).to include('fa-bell')
      end
    end

    describe '#notification_badge' do
      context 'with 1 active notification' do
        before(:each) do
          user.notifications.create(
            type: :warning,
            header: 'test',
            content: 'test'
          )
        end

        it 'returns a div with the count of active notifications' do
          expect(subject.notification_badge).to include('div')
          expect(subject.notification_badge).to include('1')
        end
      end

      context 'with only inactive notifications' do
        before(:each) do
          user.notifications.create(
            type: :warning,
            header: 'test',
            content: 'test'
          )
          user.notifications.first.dismiss!
          user.notifications.save
        end

        it 'does not return the badge markup' do
          expect(subject.notification_badge).to eq('')
        end
      end

      context 'with only active and inactive notifications' do
        before(:each) do
          user.notifications.create(
            type: :warning,
            header: 'test',
            content: 'test'
          )
          2.times do |i|
            user.notifications.create(
              type: :notice,
              header: i,
              content: i
            )
          end
          user.notifications.first.dismiss!
          user.notifications.save
        end

        it 'returns a div with the count of active notifications' do
          expect(subject.notification_badge).to include('div')
          expect(subject.notification_badge).to include('2')
        end
      end
    end

    describe '#notification_sidebar' do
      before(:each) do
        user.notifications.create(
          type: :warning,
          header: 'decorated_notification',
          content: 'decorated_notification'
        )
      end

      it 'renders content to the page' do
        expect(subject.notification_sidebar).to include('decorated_notification')
      end
    end

    describe '#account_toggle' do
      it 'renders the account_toggle partial' do
        expect(subject.account_toggle).to eq('')
      end
    end

    describe '#notifications_heading' do
      context 'when notifications are present' do
        before(:each) do
          user.notifications.create(
            type: :warning,
            header: 'test',
            content: 'test'
          )
        end

        it 'returns the correct heading' do
          expect(subject.notifications_heading).to include('Most Recent Notifications')
        end
      end

      context 'when notifications are not present' do
        it 'returns the correct heading' do
          expect(subject.notifications_heading).to include('No Recent Notifications')
        end

        it 'italicizes the message' do
          expect(subject.notifications_heading).to include('italic')
        end
      end
    end
  end
end
