require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "create a valid user" do
    user = User.new(username: "Test", email: "test@example.com", password: "test")
    assert user.valid?
  end

  test "User requires a user name" do
    user = User.new(username: "", email: "test@example.com", password: "test")
    assert_not user.valid?
    assert_match(/blank/, (user.errors[:username].to_s))
  end

  test "User requires an email address" do
    user = User.new(username: "Test", email: "", password: "test")
    assert_not user.valid?
    assert_match(/blank/, (user.errors[:email].to_s))
  end

  test "User requires a password" do
    user = User.new(username: "Test", email: "test@example.com", password: "")
    assert_not user.valid?
    assert_match(/blank/, (user.errors[:password].to_s))
  end

  test "user email saved in downcase" do
    user = User.new(username: "Test", email: "TEST@EXAMPLE.COM", password: "test")
    user.save
    assert_equal(user.email, "test@example.com")
  end

  test "user name is not case sensitive" do
    user1 = User.new(username: "Test1", email: "test1@example.com", password: "test1")
    user1.save
    assert user1.valid?

    user2 = User.new(username: "TEST1", email: "test2@example.com", password: "test2")
    assert_not user2.valid?
    assert_match(/taken/, (user2.errors[:username].to_s))
  end

  test "user name more than 3 character" do
    user = User.new(username: "tt", email: "test@example.com", password: "test")
    assert_not user.valid?
    assert_match(/too short/, (user.errors[:username].to_s))
  end

  test "user name less than 25 characters" do
    user = User.new(username: "t" * 26, email: "test@example.com", password: "test")
    assert_not user.valid?
    assert_match(/too long/, (user.errors[:username].to_s))
  end

  test "email is not case sensitive" do
    user1 = User.new(username: "Test1", email: "TEST1@EXAMPLE.COM", password: "test1")
    user1.save
    assert user1.valid?

    user2 = User.create(username: "Test2", email: "test1@example.com", password: "test2")
    assert_not user2.valid?
    assert_match(/taken/, (user2.errors[:email].to_s))
  end

  test "invalid email format rejected" do
    user = User.new(username: "test", email: "test-&example@.com", password: "test")
    assert_not user.valid?
    assert_match(/invalid/, (user.errors[:email].to_s))
  end

  test "email is less than 105 characters" do
    long_email = "longstring"*10 <<  "@example.com"
    # puts long_email
    user = User.new(username: "test", email: long_email, password: "test")
    assert_not user.valid?
    assert_match(/too long/, (user.errors[:email].to_s))
  end

  # test "user has many articles" do
  #   flunk("test not implemented, yet...")
  # end
end
