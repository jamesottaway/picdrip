$: << File.dirname(__FILE__)+'/../../lib'

WEB_DRIVER = (ENV['WEB_DRIVER'] || :chrome).to_sym

require 'watir-webdriver'
require 'watir-page-helper'
require 'pages.rb'

module Browser
  BROWSER = Watir::Browser.new WEB_DRIVER

  def visit page_class, &block
    on page_class, true, &block
  end

  def on page, visit=false, &block
    page_class = Object.const_get "#{page.to_s.capitalize}Page"
    page = page_class.new BROWSER, visit
    block.call page if block
    page
  end

  def site name
    @site = name
  end
end

World Browser

After do
  Browser::BROWSER.clear_cookies
end

at_exit do
  Browser::BROWSER.close
end