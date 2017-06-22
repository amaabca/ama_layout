module AmaLayoutNavigationHelper

  def navigation
    return AmaLayout::Navigation.non_member unless member?
    case
    when in_renewal_late?
      AmaLayout::Navigation.member_in_renewal_late
    when in_renewal?
      AmaLayout::Navigation.member_in_renewal
    else
      AmaLayout::Navigation.member
    end
  end

  private

  def member?
    member
  end

  def in_renewal?
    in_renewal
  end

  def in_renewal_late?
    status == "AL"
  end
end
