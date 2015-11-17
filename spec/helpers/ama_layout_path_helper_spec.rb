describe AmaLayoutPathHelper do
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

  describe "#gatekeeper_profile_path" do
    it "returns the profile path" do
      expect(helper.gatekeeper_profile_path).to eq "#{gatekeeper_site}/user/edit"
    end
  end

  describe "#youraccount_dashboard_path" do
    it "returns the dashboard path" do
      expect(helper.youraccount_dashboard_path).to eq "#{youraccount_site}/dashboard"
    end
  end

  describe "#youraccount_help_path" do
    it "returns the help path" do
      expect(helper.youraccount_help_path).to eq "#{youraccount_site}/help"
    end
  end

  describe "#youraccount_billing_path" do
    it "returns the billing path" do
      expect(helper.youraccount_billing_path).to eq "#{youraccount_site}/billing"
    end
  end

  describe "#youraccount_automatic_credit_card_renewals_path" do
    it "returns the automatic credit card renewal path" do
      expect(helper.youraccount_automatic_credit_card_renewals_path).to eq "#{youraccount_site}/automatic_credit_card_renewals"
    end
  end

  describe "#youraccount_ebill_path" do
    it "returns the ebill path" do
      expect(helper.youraccount_ebill_path).to eq "#{youraccount_site}/ebill"
    end
  end

  describe "#youraccount_reward_dollars_path" do
    it "returns the reward dollars path" do
      expect(helper.youraccount_reward_dollars_path).to eq "#{youraccount_site}/reward_dollars"
    end
  end

  describe "#youraccount_membership_path" do
    it "returns the membership path" do
      expect(helper.youraccount_membership_path).to eq "#{youraccount_site}/membership"
    end
  end

  describe "#youraccount_new_membership_update_path" do
    it "returns the new membership path" do
      expect(helper.youraccount_new_membership_update_path).to eq "#{youraccount_site}/membership_update/new"
    end
  end

  describe "#youraccount_memberships_printcard_path" do
    it "returns the printcard path" do
      expect(helper.youraccount_memberships_printcard_path).to eq "#{youraccount_site}/memberships/printcard"
    end
  end

  describe "#youraccount_subscriptions_path" do
    it "returns the subscriptions path" do
      expect(helper.youraccount_subscriptions_path).to eq "#{youraccount_site}/subscriptions"
    end
  end

  describe "#youraccount_westworld_path" do
    it "returns the westworld path" do
      expect(helper.youraccount_westworld_path).to eq "#{youraccount_site}/westworld"
    end
  end

  describe "#youraccount_privacy_path" do
    it "returns the privacy path" do
      expect(helper.youraccount_privacy_path).to eq "#{youraccount_site}/privacy"
    end
  end

  describe "#youraccount_terms_path" do
    it "returns the terms path" do
      expect(helper.youraccount_terms_path).to eq "#{youraccount_site}/terms"
    end
  end

  describe "#insurance_path" do
    it "returns the profile path" do
      expect(helper.insurance_path).to eq insurance_site
    end
  end

  describe "#membership_path" do
    it "returns the membership esso reload path" do
      expect(helper.membership_esso_reload_path).to eq "#{membership_site}/reward_cards"
    end
  end

  describe "#driveredonline_path" do
    it "returns the driveredonile path" do
      expect(helper.driveredonline_path).to eq "#{driveredonline_site}"
    end
  end
end
