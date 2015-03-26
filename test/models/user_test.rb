require 'test_helper'

class UserTest < ActiveSupport::TestCase
  	michael = User.create(name: "Andrew", email: "test@test.com", password: "passwerd", password_confirmation: "passwerd", admin: false)
	archer = User.create(name: "Steve", email: "test@gmail.com", password: "passwerd", password_confirmation: "passwerd", admin: false)
    assert_not michael.friends?(archer)
    michael.friend(archer)
    assert michael.friends?(archer)
    michael.unfriend(archer)
    assert_not michael.friends?(archer)
end

