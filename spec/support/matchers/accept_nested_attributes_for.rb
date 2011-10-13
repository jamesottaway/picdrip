RSpec::Matchers.define :accept_nested_attributes_for do |attribute|
  match do |model|
    model.methods.include? "#{attribute}_attributes=".to_sym
  end

  failure_message_for_should do |model|
    "#{model.class} does not accept nested attributes for #{attribute}"
  end

  failure_message_for_should_not do |model|
    "#{model.class} incorrectly accepts nested attributes for #{attribute}"
  end
end