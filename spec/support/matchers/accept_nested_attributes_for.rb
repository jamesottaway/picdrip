RSpec::Matchers.define :accept_nested_attributes_for do |attribute|
  match do |model|
    model.methods.include? "#{attribute}_attributes="
  end
end