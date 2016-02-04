require 'spec_helper'

describe PagesController, type: :controller do
  UNSUPPORTED_BROWSER_HEADERS = {
    'IE 6' => 'MSIE 6.0',
    'IE 7' => 'MSIE 7.0',
    'IE 8' => 'MSIE 8.0'
  }

  SUPPORTED_BROWSER_HEADERS = {
    'IE 9'  => 'MSIE 9.0',
    'IE 10' => 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)',
    'IE 11' => 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko',
    'EDGE'  => 'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10136'
  }

  let(:browser_url) { 'http://windows.microsoft.com/en-ca/internet-explorer/download-ie' }
  let(:message) do
    I18n.t('errors.unsupported_ie', ie_path: browser_url)
    .gsub(/>/, '&gt;')
    .gsub(/</, '&lt;')
    .gsub(/'/, '&#39;')
  end

  describe '#index' do
    context 'with unsupported user agent' do
      UNSUPPORTED_BROWSER_HEADERS.each do |name, header|
        it "renders a flash alert for #{name}" do
          request.env['HTTP_USER_AGENT'] = header
          get :index

          expect(response.body).to include(message)
        end
      end
    end

    context 'with supported user agent' do
      SUPPORTED_BROWSER_HEADERS.each do |name, header|
        it "does not render a flash alert for #{name}" do
          request.env['HTTP_USER_AGENT'] = header
          get :index

          expect(response.body).to_not include(message)
        end
      end
    end
  end
end
