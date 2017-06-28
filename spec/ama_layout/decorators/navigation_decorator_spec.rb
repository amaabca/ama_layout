describe AmaLayout::NavigationDecorator do
  let(:navigation) { FactoryGirl.build(:navigation) }
  let(:navigation_presenter) { navigation.decorate }
  let(:gatekeeper_site) { "http://auth.waffles.ca" }
  let(:youraccount_site) { "http://youraccount.waffles.ca" }
  let(:insurance_site) { "http://insurance.waffles.ca" }
  let(:membership_site) { "http://membership.waffles.ca" }
  let(:driveredonline_site) { "http://driveredonline.waffles.ca" }
  let(:registries_site) { "http://registries.waffles.ca" }
  let(:automotive_site) { "http://automotive.waffles.ca" }
  let(:travel_site) { "http://travel.waffles.ca" }
  let(:notification) do
    AmaLayout::Notification.new(
      type: :warning,
      header: 'test',
      content: 'test',
      created_at: DateTime.current,
      active: true
    )
  end

  before(:each) do
    allow(Rails.configuration).to receive(:gatekeeper_site).and_return(gatekeeper_site)
    allow(Rails.configuration).to receive(:youraccount_site).and_return(youraccount_site)
    allow(Rails.configuration).to receive(:insurance_site).and_return(insurance_site)
    allow(Rails.configuration).to receive(:membership_site).and_return(membership_site)
    allow(Rails.configuration).to receive(:driveredonline_site).and_return(driveredonline_site)
    allow(Rails.configuration).to receive(:registries_site).and_return(registries_site)
    allow(Rails.configuration).to receive(:automotive_site).and_return(automotive_site)
    allow(Rails.configuration).to receive(:travel_site).and_return(travel_site)
  end

  describe "#display_name_text" do
    let(:user) { OpenStruct.new(email: 'john.doe@test.com') }

    context "name is provided" do
      let(:name) { "John D" }
      let(:nav) { AmaLayout::Navigation.new(user: user, display_name: name).decorate }

      it "has a welcome message" do
        expect(nav.display_name_text).to eq "Welcome, John D"
      end

      context "long name given" do
        let(:name) { "A Really Really Really Really Long Name" }

        it "trucates to a total of 30 characters" do
          expect(nav.display_name_text).to eq "Welcome, #{name.titleize}".truncate(30)
        end
      end
    end

    context "name is not provided" do
      let(:nav) { AmaLayout::Navigation.new(user: user).decorate }

      it "returns the user's email address" do
        expect(nav.display_name_text).to eq user.email
      end

      context "a really long email" do
        let(:user) { OpenStruct.new(email: 'areallyreallyreallylongemail@test.com') }

        it "trucates to a total of 30 characters" do
          expect(nav.display_name_text).to eq user.email.truncate(30)
        end
      end
    end
  end

  describe "#items" do
    before(:each) do
      allow_any_instance_of(AmaLayout::Navigation).to receive(:user).and_return(OpenStruct.new(navigation: "member"))
    end

    it "returns an array of navigation items" do
      expect(navigation_presenter.items).to be_an Array
    end

    it "array contains decorated navigation items" do
      items = navigation_presenter.items
      items.each do |i|
        expect(i).to be_a AmaLayout::NavigationItemDecorator
      end
    end
  end

  describe "#sign_out_link" do
    context "with user" do
      it "returns link" do
        allow_any_instance_of(AmaLayout::Navigation).to receive(:user).and_return(OpenStruct.new(navigation: "member"))
        expect(navigation_presenter.sign_out_link).to include "Sign Out"
      end
    end

    context "without user" do
      it "does not return the link" do
        expect(navigation_presenter.sign_out_link).to eq ""
      end
    end
  end

  describe "#top_nav" do
    context "with items" do
      it "renders the partial" do
        allow_any_instance_of(AmaLayout::Navigation).to receive(:user).and_return(OpenStruct.new(navigation: "member"))
        allow_any_instance_of(Draper::HelperProxy).to receive(:render).and_return "render"
        expect(navigation_presenter.top_nav).to eq "render"
      end
    end

    context "without items" do
      it "does not renders the partial" do
        expect(navigation_presenter.top_nav).to eq nil
      end
    end
  end

  describe "#sidebar" do
    context "with items" do
      it "renders the partial" do
        allow_any_instance_of(AmaLayout::Navigation).to receive(:user).and_return(OpenStruct.new(navigation: "member"))
        allow_any_instance_of(Draper::HelperProxy).to receive(:render).and_return "render"
        expect(navigation_presenter.sidebar).to eq "render"
      end
    end

    context "without items" do
      it "does not renders the partial" do
        expect(navigation_presenter.sidebar).to eq nil
      end
    end
  end

  context "account toggle" do
    it "in ama_layout it renders a blank partial" do
      allow_any_instance_of(AmaLayout::Navigation).to receive(:user).and_return(OpenStruct.new(navigation: "member"))
      allow_any_instance_of(Draper::HelperProxy).to receive(:render).and_return "render"
      expect(navigation_presenter.account_toggle).to eq "render"
    end
  end

  describe '#notifications' do
    let(:notifications) { [notification] }
    let(:user) { OpenStruct.new(navigation: 'member', notifications: notifications) }
    let(:navigation) { FactoryGirl.build :navigation, user: user }
    subject { described_class.new(navigation) }

    it 'renders the content to the page' do
      expect(subject.h).to receive(:render).once.and_return true
      expect(subject.notifications).to be true
    end
  end

  describe '#notification_badge' do
    let(:user) { OpenStruct.new(navigation: 'member', notifications: notifications) }
    let(:notifications) { OpenStruct.new(active: [notification]) }
    let(:navigation) { FactoryGirl.build :navigation, user: user }
    subject { described_class.new(navigation) }

    it 'returns a span with the count of active notifications' do
      expect(subject.notification_badge).to include('span')
      expect(subject.notification_badge).to include('1')
    end
  end
end
