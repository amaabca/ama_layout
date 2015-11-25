describe AmaLayout::NavigationDecorator do
  let(:navigation) { FactoryGirl.build(:navigation) }
  let(:navigation_presenter) { navigation.decorate }
  let(:gatekeeper_site) { "http://auth.waffles.ca" }
  let(:youraccount_site) { "http://youraccount.waffles.ca" }
  let(:insurance_site) { "http://insurance.waffles.ca" }
  let(:membership_site) { "http://membership.waffles.ca" }
  let(:driveredonline_site) { "http://driveredonline.waffles.ca" }

  before(:each) do
    allow(Rails.configuration).to receive(:gatekeeper_site).and_return(gatekeeper_site)
    allow(Rails.configuration).to receive(:youraccount_site).and_return(youraccount_site)
    allow(Rails.configuration).to receive(:insurance_site).and_return(insurance_site)
    allow(Rails.configuration).to receive(:membership_site).and_return(membership_site)
    allow(Rails.configuration).to receive(:driveredonline_site).and_return(driveredonline_site)
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
end