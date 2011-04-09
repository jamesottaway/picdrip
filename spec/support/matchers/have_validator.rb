RSpec::Matchers.define :have_validator do |validator, params|
  match do |model|
    validators = model.validators.select {|v| v.class == validator and v.attributes.include? params[:on]}
    validators = validators.select {|v| v.options == params[:options] } if params[:options]
    validators.size == 1
  end
end