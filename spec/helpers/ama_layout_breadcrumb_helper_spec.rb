describe AmaLayoutBreadcrumbHelper do
  describe "#show_breadcrumbs" do
    it "renders breadcrumbs" do
      helper.extend BreadcrumbsOnRails::ActionController::HelperMethods
      helper.add_breadcrumb "Ama Online Account", "#"
      expect(helper.show_breadcrumbs).to include "<a href=\"#\">Ama Online Account</a>"
    end
  end
end
