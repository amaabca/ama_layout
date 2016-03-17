module AmaLayout
  module ActionController
    extend ActiveSupport::Concern

    included do
      before_action :check_browser
    end

    private

    def check_browser
      browser_url = 'http://windows.microsoft.com/en-ca/internet-explorer/download-ie'
      flash[:alert] = I18n.t("errors.unsupported_ie", ie_path: browser_url) unless browser.modern?
    end
  end
end
