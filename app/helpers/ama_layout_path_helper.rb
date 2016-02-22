module AmaLayoutPathHelper
  def gatekeeper_profile_path
    "#{Rails.configuration.gatekeeper_site}/user/edit"
  end

  def youraccount_dashboard_path
    "#{Rails.configuration.youraccount_site}/dashboard"
  end

  def youraccount_help_path
    "#{Rails.configuration.youraccount_site}/help"
  end

  def youraccount_billing_path
    "#{Rails.configuration.youraccount_site}/billing"
  end

  def youraccount_automatic_credit_card_renewals_path
    "#{Rails.configuration.youraccount_site}/automatic_credit_card_renewals"
  end

  def youraccount_ebill_path
    "#{Rails.configuration.youraccount_site}/ebill"
  end

  def youraccount_reward_dollars_path
    "#{Rails.configuration.youraccount_site}/reward_dollars"
  end

  def youraccount_membership_path
    "#{Rails.configuration.youraccount_site}/membership"
  end

  def youraccount_new_membership_update_path
    "#{Rails.configuration.youraccount_site}/membership_update/new"
  end

  def youraccount_memberships_printcard_path
    "#{Rails.configuration.youraccount_site}/memberships/printcard"
  end

  def youraccount_subscriptions_path
    "#{Rails.configuration.youraccount_site}/subscriptions"
  end

  def youraccount_amainsider_path
    "#{Rails.configuration.youraccount_site}/amainsider"
  end

  def youraccount_privacy_path
    "#{Rails.configuration.youraccount_site}/privacy"
  end

  def youraccount_terms_path
    "#{Rails.configuration.youraccount_site}/terms"
  end

  def insurance_path
    Rails.configuration.insurance_site
  end

  def membership_esso_reload_path
    "#{Rails.configuration.membership_site}/reward_cards"
  end

  def driveredonline_path
    Rails.configuration.driveredonline_site
  end
end
