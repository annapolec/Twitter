require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid sign up" do
  	get signup_path
  	assert_no_difference 'User.count' do
  	post users_path, user: 	{ name: "",
  															email: "ania@invalid",
  															password: "foo",
  															password_confirmation: "bar"}
  	end
  	assert_template 'users/new'
  end

  test "valid sign up" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  	post_via_redirect users_path, user: {  name: "Ania Polec",
  												            		 email: "ania@valid.com",
  												            		 password: "123456",
  												            		 password_confirmation: "123456" }
  	end
  	assert_template 'users/show'
    assert is_logged_in?
  end
end
