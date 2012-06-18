require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "invitation confirmation" do
    user = users(:joe)
    invitor = users(:juan_senior)
    email = UserMailer.invitation_confirmation(user, invitor).deliver
    assert !ActionMailer::Base.deliveries.empty?
    assert_match(/<h1>Welcome to markspells.com<\/h1>/, email.encoded)
    assert_match(/Welcome to markspells.com/, email.encoded)
  end

end
