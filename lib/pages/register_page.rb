class RegisterPage < BasePageClass
  direct_url 'http://localhost:9292/users/sign_up'

  text_field :email, :name => 'user[email]'
  text_field :password, :name => 'user[password]'
  text_field :password_confirmation, :name => 'user[password_confirmation]'
  button :register, :type => 'submit'
end