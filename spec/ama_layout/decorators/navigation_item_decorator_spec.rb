describe AmaLayout::NavigationItemDecorator do
  let(:navigation_item) { FactoryGirl.build(:navigation_item) }
  let(:navigation_item_presenter) { navigation_item.decorate }
  let(:items) { [{ text: "Othersite Overview", link: "othersite.com"}] }

  describe "#sub_nav" do
    before(:each) do
      navigation_item.sub_nav = items
    end

    it "returns an array of navigation items" do
      expect(navigation_item_presenter.sub_nav).to be_an Array
    end

    it "array contains decorated navigation items" do
      items = navigation_item_presenter.sub_nav
      items.each do |i|
        expect(i).to be_a AmaLayout::NavigationItemDecorator
      end
    end
  end

  describe "#sub_nav_class" do
    context "with sub_nav" do
      it "return the class" do
        navigation_item.sub_nav = items
        expect(navigation_item_presenter.sub_nav_class).to eq "has-dropdown"
      end
    end

    context "without sub_nav" do
      it "does not returns the class" do
        expect(navigation_item_presenter.sub_nav_class).to eq nil
      end
    end
  end

  describe "#top_sub_nav" do
    context "with items" do
      it "renders the partial" do
        navigation_item.sub_nav = items
        allow_any_instance_of(Draper::HelperProxy).to receive(:render).and_return "render"
        expect(navigation_item_presenter.top_sub_nav).to eq "render"
      end
    end

    context "without items" do
      it "does not renders the partial" do
        expect(navigation_item_presenter.top_sub_nav).to eq nil
      end
    end
  end

  describe "#sidebar_sub_nav" do
    context "with items" do
      it "renders the partial" do
        navigation_item.sub_nav = items
        allow_any_instance_of(Draper::HelperProxy).to receive(:render).and_return "render"
        expect(navigation_item_presenter.sidebar_sub_nav).to eq "render"
      end
    end

    context "without items" do
      it "does not renders the partial" do
        expect(navigation_item_presenter.sidebar_sub_nav).to eq nil
      end
    end
  end

  describe "#active_class" do
    context "with active_link" do
      it "return the class" do
        navigation_item.current_url = "othersite.com"
        navigation_item.sub_nav = items
        expect(navigation_item_presenter.active_class).to eq "side-nav__child-link--active-page"
      end
    end

    context "without active_link" do
      it "does not returns the class" do
        expect(navigation_item_presenter.active_class).to eq nil
      end
    end
  end
end
