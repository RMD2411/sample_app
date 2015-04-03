require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                       password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end
  
  test "Email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
  
  test "name should not be that long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be that long" do
    @user.email = "a" * 251
    assert_not @user.valid?
  end
  
  test "should be valid email address" do
    valid_addresses = %w[user@example.com user@foo.com A_user-er@foo.bar.org first.last@google.com]
    
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} needs to be valid"
    end
    
  end
  
  test "email validation should reject invalid address" do
    invalid_address = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    
    invalid_address.each do |invalid_add|
      @user.email = invalid_add
      assert_not @user.valid?, "#{invalid_add.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  
end
