describe AmaLayout::Agent::NavigationDecorator do
  let(:name) { "John D" }
  let(:cash_drawer) { OpenStruct.new(name: 'Edmonton Main') }
  let(:user) { OpenStruct.new(email: 'john.doe@test.com', cash_drawers: [cash_drawer]) }
  let(:navigation) { FactoryGirl.build(:agent_navigation, user: user, display_name: name) }
  let(:navigation_presenter) { navigation.decorate }

  describe "#display_name_text" do
    context "user does have a cash drawer" do
      it "is part of the welcome message" do
        expect(navigation_presenter.display_name_text).to eq "Welcome, John D - Edmonton Main"
      end

      context "the user does not have a cash drawer" do
        let(:cash_drawer) { nil }
        it "is not part of the welcome message" do
          expect(navigation_presenter.display_name_text).to eq "Welcome, John D"
        end
      end
    end
  end

  describe "#items" do
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
        expect(navigation_presenter.sign_out_link).to include "Sign Out"
      end
    end

    context "without user" do
      let(:user) { nil }

      it "does not return the link" do
        expect(navigation_presenter.sign_out_link).to eq ""
      end
    end
  end

  describe "#top_nav" do
    context "with user" do
      it "renders the partial" do
        allow_any_instance_of(Draper::HelperProxy).to receive(:render).and_return "render"
        expect(navigation_presenter.top_nav).to eq "render"
      end
    end

    context "without user" do
      let(:user) { nil }

      it "does not renders the partial" do
        expect(navigation_presenter.top_nav).to eq ''
      end
    end
  end

  describe "#sidebar" do
    context "with user" do
      it "renders the partial" do
        allow_any_instance_of(Draper::HelperProxy).to receive(:render).and_return "render"
        expect(navigation_presenter.sidebar).to eq "render"
      end
    end

    context "without user" do
      let(:user) { nil }

      it "does not renders the partial" do
        expect(navigation_presenter.sidebar).to eq ''
      end
    end
  end
end
