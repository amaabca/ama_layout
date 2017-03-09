module AmaLayoutContentHelper
  def greeting
    cookies["logged_in_meta"]
  end

  def utm_source
    Rails.configuration.site_name.downcase.gsub(/\W/, "")
  end

  def active_section(nav_item)
    paths = [nav_item.link]
    paths += nav_item.sub_nav.map(&:link)
    active_page(*paths)
  end

  def active_page(*path)
    "activepage" if path.include?(request.fullpath) || path.include?(request.url)
  end

  def active_domain(domain)
    "active" if request.url.include?(domain)
  end

  def renew_or_join_path(logged_in)
    return "" if logged_in
    link_to("Become a Member", "http://www.ama.ab.ca/membership/join-ama-online", target: "_blank")
  end

  def gift_or_pricing_path(logged_in)
    return "" if logged_in
    link_to("Gift Membership", "http://www.ama.ab.ca/membership-rewards/ama-gift-membership", target: "_blank")
  end

  def dropdown_menu(logged_in, greeting)
    return "" unless logged_in
    render partial: "ama_layout/dropdown_menu", locals: { logged_in: logged_in, greeting: greeting }
  end

  def tablet_menu(logged_in, greeting)
    return "" unless logged_in
    render partial: "ama_layout/tablet_menu", locals: { logged_in: logged_in, greeting: greeting }
  end

  def tablet_signout(logged_in)
    return "" unless logged_in
    render "ama_layout/tablet_signout"
  end

  def notice(notice)
    render "ama_layout/notice" if notice
  end

  def alert(alert)
    render "ama_layout/alert" if alert
  end

  def success_message(success)
    render "ama_layout/success" if success
  end
end
