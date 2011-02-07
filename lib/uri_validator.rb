require 'uri'

class UriValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    begin  
      URI.parse(value)
    rescue
      object.errors[attribute] << (options[:message] || "is not a valid URI")
    end
  end
end
