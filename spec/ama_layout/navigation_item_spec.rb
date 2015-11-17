describe AmaLayout::NavigationItem do
  let(:site_domain) { "http://waffleemporium.ca" }

  describe "#initialize" do
    it "returns a navigation item" do
      params = { text: "Gotham Overview", icon: "fa-tachometer", link: "#{site_domain}/gotica", alt: "Back to my dashboard", current_url: "#{site_domain}" }
      expect(AmaLayout::NavigationItem.new(params)).to be_a AmaLayout::NavigationItem
    end
  end

  describe "#sub_nav" do
    it "set the subnav" do
      subject.current_url = "#{site_domain}"
      items = [{ text: "Othersite Overview", link: "#{site_domain}/othersite"}]
      subject.sub_nav = items
      expect(subject.sub_nav).to be_an Array
      expect(subject.sub_nav.first.link).to include items.first[:link]
      expect(subject.sub_nav.first.text).to include items.first[:text]
    end
  end
end
