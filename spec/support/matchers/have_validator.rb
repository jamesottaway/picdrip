RSpec::Matchers.define :have_validator do |validator, params|
  match do |model|
    validators = model.class.validators.select { |v| v.class == validator and v.attributes.include? params[:on] }
    validators = validators.select { |v| params[:options].all? { |po| v.options.any? { |vo| vo == po } } } if params[:options]
    validators.size == 1
  end
end