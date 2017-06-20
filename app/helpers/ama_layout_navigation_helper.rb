module AmaLayoutNavigationHelper

  def navigation
    binding.pry
    case
    when in_renewal?
      AmaLayout::Navigation.member_in_renewal
    when in_renewal_late?
      AmaLayout::Navigation.member_in_renewal_late
    else
      AmaLayout::Navigation.member
    end
  end

  private

  def in_renewal?
    binding.pry
    in_renewal
  end

  def in_renewal_late?
    binding.pry
    status == "AL"
  end
end
