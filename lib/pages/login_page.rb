class LoginPage < BasePageClass
  direct_url 'http://localhost:9292/users/sign_in'

  text_field :email, :name => 'user[email]'
  text_field :password, :name => 'user[password]'
  button :login, :type => 'submit'
end