describe AmaLayout::Navigation do
  let(:gatekeeper_site) { "http://auth.waffles.ca" }
  let(:youraccount_site) { "http://youraccount.waffles.ca" }
  let(:insurance_site) { "http://insurance.waffles.ca" }
  let(:membership_site) { "http://membership.waffles.ca" }
  let(:driveredonline_site) { "http://driveredonline.waffles.ca" }
  let(:registries_site) { "http://registries.waffles.ca" }

  before(:each) do
    allow(Rails.configuration).to receive(:gatekeeper_site).and_return(gatekeeper_site)
    allow(Rails.configuration).to receive(:youraccount_site).and_return(youraccount_site)
    allow(Rails.configuration).to receive(:insurance_site).and_return(insurance_site)
    allow(Rails.configuration).to receive(:membership_site).and_return(membership_site)
    allow(Rails.configuration).to receive(:driveredonline_site).and_return(driveredonline_site)
    allow(Rails.configuration).to receive(:registries_site).and_return(registries_site)
  end

  describe "#nav_file_path" do
    let(:file_path) { File.join(Gem.loaded_specs["ama_layout"].full_gem_path, "lib", "ama_layout", "navigation.yml") }

    it "defaults to lib/ama_layout/navigation.yml" do
      expect(subject.nav_file_path).to eq file_path
    end

    context "overridden file path" do
      let(:file_path) do
        File.join(Gem.loaded_specs["ama_layout"].full_gem_path, "spec", "ama_layout", "fixtures", "navigation.yml")
      end
      let(:user) { double("user", navigation: AmaLayout::Navigation.member) }
      let(:subject) { described_class.new(user: user, nav_file_path: file_path) }

      it "uses the overridden file path" do
        expect(subject.items.first.text).to eq "Fixture"
      end
    end
  end

  describe "#display_name" do
    let(:email) { "test@test.com" }
    let(:user) { OpenStruct.new(email: email) }

    context "when a display name is set" do
      let(:name) { 'Test' }
      let(:subject) { described_class.new(user: user, display_name: name) }

      it "returns a name" do
        expect(subject.display_name).to eq name
      end
    end

    context "with a lowercased name" do
      let(:name) { 'bob p.' }
      let(:subject) { described_class.new(user: user, display_name: name) }

      it "titlizes the name" do
        expect(subject.display_name).to eq name.titleize
      end
    end

    context "display name is not set" do
      let(:subject) { described_class.new(user: user) }

      it "returns the user's email" do
        expect(subject.display_name).to eq email
      end
    end
  end

  describe "#items" do
    before(:each) do
      subject.user = OpenStruct.new navigation: "member"
    end

    it "does not remove nil #navigation_items" do
      expect(subject.items.collect {|i| i.alt }).to include nil
    end

    it "displays links " do
      expect(subject.items.collect {|i| i.link }).to eq subject.navigation_items[subject.user.navigation].collect {|i| i["link"] }
    end

    it "contains text" do
      expect(subject.items.collect {|i| i.text }).to eq subject.navigation_items[subject.user.navigation].collect {|i| i["text"] }
    end

    it "contains icons" do
      expect(subject.items.collect {|i| i.icon }).to eq subject.navigation_items[subject.user.navigation].collect {|i| i["icon"] }
    end

    it "contains alt text" do
      expect(subject.items.collect {|i| i.alt }).to eq subject.navigation_items[subject.user.navigation].collect {|i| i["alt"] }
    end

    context "member" do
      context "subnavs" do
        context "driver education" do
          let(:driver_education_subnav) { subject.items[2].sub_nav }

          it "return the subnav items" do
            expect(driver_education_subnav[0].text).to eq "Driver Education Overview"
            expect(driver_education_subnav[0].link).to eq "#{driveredonline_site}/"

            expect(driver_education_subnav[1].text).to eq "New Driver Online Program"
            expect(driver_education_subnav[1].link).to eq "#{driveredonline_site}/dashboard"
          end
        end

        context "registries" do
          let(:registries_subnav) { subject.items[4].sub_nav }

          it "returns the subnav items" do
            expect(registries_subnav[0].text).to eq "Registries Overview"
            expect(registries_subnav[0].link).to eq "#{registries_site}/"
            expect(registries_subnav[1].text).to eq "Vehicle Registration Auto-Renew"
            expect(registries_subnav[1].link).to eq "#{registries_site}/order/registrations/new"
          end
        end
      end
    end

    context "non-member" do
      context "subnavs" do
        context "driver education" do
          let(:driver_education_subnav) { subject.items[2].sub_nav }

          it "return the subnav items" do
            expect(driver_education_subnav[0].text).to eq "Driver Education Overview"
            expect(driver_education_subnav[0].link).to eq "#{driveredonline_site}/"

            expect(driver_education_subnav[1].text).to eq "New Driver Online Program"
            expect(driver_education_subnav[1].link).to eq "#{driveredonline_site}/dashboard"
          end
        end
      end
    end

    context "member-in-renewal" do
      context "subnavs" do
        context "driver education" do
          let(:driver_education_subnav) { subject.items[2].sub_nav }

          it "return the subnav items" do
            expect(driver_education_subnav[0].text).to eq "Driver Education Overview"
            expect(driver_education_subnav[0].link).to eq "#{driveredonline_site}/"

            expect(driver_education_subnav[1].text).to eq "New Driver Online Program"
            expect(driver_education_subnav[1].link).to eq "#{driveredonline_site}/dashboard"
          end
        end
      end
    end

    context "member-in-renewal-late" do
      context "subnavs" do
        context "driver education" do
          let(:driver_education_subnav) { subject.items[2].sub_nav }

          it "return the subnav items" do
            expect(driver_education_subnav[0].text).to eq "Driver Education Overview"
            expect(driver_education_subnav[0].link).to eq "#{driveredonline_site}/"

            expect(driver_education_subnav[1].text).to eq "New Driver Online Program"
            expect(driver_education_subnav[1].link).to eq "#{driveredonline_site}/dashboard"
          end
        end
      end
    end
  end
end
