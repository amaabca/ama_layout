describe AmaLayout::Agent::Navigation do
  describe "#nav_file_path" do
    let(:file_path) { File.join(Gem.loaded_specs["ama_layout"].full_gem_path, "lib", "ama_layout", "agent_navigation.yml") }

    it "defaults to lib/ama_layout/agent_navigation.yml" do
      expect(subject.nav_file_path).to eq file_path
    end

    context "overridden file path" do
      let(:file_path) do
        File.join(Gem.loaded_specs["ama_layout"].full_gem_path, "spec", "ama_layout", "fixtures", "agent_navigation.yml")
      end
      let(:user) { double("user") }
      let(:subject) { described_class.new(user: user, nav_file_path: file_path, current_url: '/') }

      it "uses the overridden file path" do
        expect(subject.items.first.text).to eq "Waffles"
      end
    end
  end

  describe "#items" do
    it "does not remove nil #navigation_items" do
      expect(subject.items.collect(&:alt)).to include nil
    end

    it "displays links" do
      expect(subject.items.collect(&:link)).to eq subject.navigation_items.collect {|i| i["link"] }
    end

    it "contains text" do
      expect(subject.items.collect(&:text)).to eq subject.navigation_items.collect {|i| i["text"] }
    end

    it "contains icons" do
      expect(subject.items.collect(&:icon)).to eq subject.navigation_items.collect {|i| i["icon"] }
    end

    it "contains alt text" do
      expect(subject.items.collect(&:alt)).to eq subject.navigation_items.collect {|i| i["alt"] }
    end

    context "customer lookup" do
      context "main nav" do
        it "return the main nav items" do
          expect(subject.items[0].text).to eq "Customer Lookup"
          expect(subject.items[0].link).to eq ""
          expect(subject.items[0].icon).to eq ""
        end
      end
    end

    context "driver education" do
      context "main nav" do
        it "return the main nav items" do
          expect(subject.items[1].text).to eq "Driver Education"
          expect(subject.items[1].link).to eq ""
          expect(subject.items[1].icon).to eq "fa-car"
        end
      end

      context "subnavs" do
        let(:driver_education_subnav) { subject.items[1].sub_nav }

        it "return the subnav items" do
          expect(driver_education_subnav[0].text).to eq "Purchase Course"
          expect(driver_education_subnav[0].link).to eq ""

          expect(driver_education_subnav[1].text).to eq "Admin Tasks"
          expect(driver_education_subnav[1].link).to eq ""
        end
      end
    end

    context "cashout" do
      context "main nav" do
        it "return the main nav items" do
          expect(subject.items[2].text).to eq "Cashout"
          expect(subject.items[2].link).to eq ""
          expect(subject.items[2].icon).to eq ""
        end
      end
    end
  end
end
