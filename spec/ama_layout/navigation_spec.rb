describe AmaLayout::Navigation do
  let(:gatekeeper_site) { "http://auth.waffles.ca" }
  let(:youraccount_site) { "http://youraccount.waffles.ca" }
  let(:insurance_site) { "http://insurance.waffles.ca" }
  let(:membership_site) { "http://membership.waffles.ca" }
  let(:driveredonline_site) { "http://driveredonline.waffles.ca" }
  let(:registries_site) { "http://registries.waffles.ca" }
  let(:automotive_site) { "http://automotive.waffles.ca"}
  let(:travel_site) { "http://travel.waffles.ca"}

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
        include_examples "member_navigation"
      end
    end

    context "non-member" do
      context "subnavs" do
        context "driver education" do
          before(:each) do
            subject.user = OpenStruct.new navigation: "non-member"
          end
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
        before(:each) do
          subject.user = OpenStruct.new navigation: "member-in-renewal"
        end

        include_examples "member_navigation"

        context "membership" do
          let(:membership_subnav) { subject.items[1].sub_nav }

          it "has the correct subnav items" do
            expect(membership_subnav[1].text).to eq "Renew Membership"
            expect(membership_subnav[1].link).to eq "#{membership_site}/renews/new"
          end
        end
      end
    end

    context "member-in-renewal-late" do
      before(:each) do
        subject.user = OpenStruct.new navigation: "member-in-renewal-late"
      end

      context "main nav" do
        it "return the main nav items" do
          expect(subject.items[0].text).to eq "Account Dashboard"
          expect(subject.items[0].link).to eq "#{gatekeeper_site}/"
          expect(subject.items[1].text).to eq "Renew"
          expect(subject.items[1].link).to eq "#{membership_site}/renews/new"
        end
      end

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

    context "member-with-outstanding-balance" do
      before(:each) do
        subject.user = OpenStruct.new navigation: "member-with-outstanding-balance"
      end

      context "main nav" do
        it "return the main nav items" do
          expect(subject.items[0].text).to eq "Account Dashboard"
          expect(subject.items[0].link).to eq "#{gatekeeper_site}/"
          expect(subject.items[1].text).to eq "Pay Outstanding Balance"
          expect(subject.items[1].link).to eq "#{membership_site}/membership/payments/new"
        end
      end

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
