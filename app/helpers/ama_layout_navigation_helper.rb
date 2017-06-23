module AmaLayoutNavigationHelper

  def navigation(user)
    return AmaLayout::Navigation.non_member unless _member?(user.member?)
    case
    when _in_renewal_late?(user.status)
      AmaLayout::Navigation.member_in_renewal_late
    when _in_renewal?(user.in_renewal)
      AmaLayout::Navigation.member_in_renewal
    else
      AmaLayout::Navigation.member
    end
  end

  private

  def _member?(member)
    member
  end

  def _in_renewal?(in_renewal)
    in_renewal
  end

  def _in_renewal_late?(status)
    status == "AL"
  end
end
