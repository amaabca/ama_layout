module AmaLayoutNavigationHelper

  def navigation
    return AmaLayout::Navigation.non_member unless _member?(member?)
    case
    when _in_renewal_late?(status)
      AmaLayout::Navigation.member_in_renewal_late
    when _in_renewal?(in_renewal)
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
