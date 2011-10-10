require 'pages/base_page_class.rb'
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each {|r| load r }