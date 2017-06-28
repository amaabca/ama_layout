module AmaLayout
  module NavigationHelper
    def navigation
      return AmaLayout::Navigation.non_member unless member?
      case
      when _in_renewal_late?
        AmaLayout::Navigation.member_in_renewal_late
      when _in_renewal?
        AmaLayout::Navigation.member_in_renewal
      else
        AmaLayout::Navigation.member
      end
    end

    private

    def _in_renewal?
      in_renewal
    end

    def _in_renewal_late?
      status == "AL"
    end
  end
end
