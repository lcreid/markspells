require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  # USER INVITE ANOTHER USER FOR PRE-PRODUCTION PHASE
  test "invitation form if not logged in" do
    get :invite
		assert_redirected_to new_user_session_path
  end

  test "invitation form should error if no id provided" do
		sign_in users(:juana_senior)
    get :invite
		assert_response :error
  end

  test "invitation form" do
    u = users(:juana_senior)
		sign_in u
    get :invite, :id => u.id
    assert_response :success
  end

  test "submit invitation form redirects to signin page" do
    post :send_invitation
		assert_redirected_to new_user_session_path
  end

  test "submit invitation form errors if no id provided" do
    u = users(:juana_senior)
		sign_in u
    params = {
      :user => {
          :email => "a@example.com"
      }
    }
    post :send_invitation, params
		assert_response :error
  end

  test "submit invitation form errors if no e-mail provided" do
    u = users(:juana_senior)
		sign_in u
    params = {
      :id => u.id,
      :user => {
      }
    }
    post :send_invitation, params
		assert_response :error
  end

  test "submit invitation sends e-mail" do
    request.env['devise.mapping'] = Devise.mappings[:user]
    u = users(:juana_senior)
		sign_in u

		new_user_email = "a@example.com"
		assert_difference 'ActionMailer::Base.deliveries.count', 1 do
      assert_difference 'User.all.count', 1 do
        params = {
          :id => u.id,
          :user => {
            :email => new_user_email
          }
        }
        post :send_invitation, params
        assert ! flash.notice.empty?
        assert_redirected_to edit_user_path(u)
      end
    end

    #assert_equal 1, ActionMailer::Base.deliveries.count
    email = ActionMailer::Base.deliveries.last

    new_user = User.find_by_email(new_user_email)
    assert_match(/<h1>Welcome to markspells.com, #{new_user.email}<\/h1>/, email.encoded)
    assert_match(/Welcome to markspells.com, #{new_user.email}/, email.encoded)
    assert_match(/#{u.email} has invited you/, email.encoded)

    assert_match(/#{new_user.confirmation_token}/, email.encoded)
  end

	# PARENT ASSIGN ANOTHER PARENT
	test "delgate parent should redirect to logon if not logged in" do
		get :delegate_parent, :id => '0'
		assert_redirected_to new_user_session_path
	end

	test "delgate parent should error if no id provided" do
		sign_in users(:juana_senior)
		get :delegate_parent
		assert_response :error
	end

  test 'delgate parent' do
    u = users(:juana_senior)
    sign_in u
	 get :delegate_parent, :id => u.id
    assert_response :success

		assert_select "form", 1 do
			assert_select "input#email", 1
			assert_select "input[type=checkbox]", 2
		end
	end

	test "create delgate parent redirects to login page" do
		params = {
			:id => 0,
			:user_ids => [ users(:one_mixed).id	]
		}
		post :create_delegate_parent, params
		assert_redirected_to new_user_session_path
	end

	test "create delgate parent errors if no email" do
		u = users(:juana_senior)
		sign_in u

		params = {
			:id => u.id,
			:user_ids => [ users(:one_mixed).id	]
		}
		post :create_delegate_parent, params
		assert_response :error
	end

	test "create delgate parent errors if no id" do
		u = users(:juana_senior)
		sign_in u

		params = {
			:id => u.id,
			:user_ids => [ users(:one_mixed).id	]
		}
		post :create_delegate_parent, params
		assert_response :error
	end

	test "create delgate parent redirects to try again if email not in db" do
		u = users(:juana_senior)
		sign_in u

		params = {
			:id => u.id,
			:email => "juan_junior@example.com",
			:user_ids => [ users(:one_mixed).id	]
		}
		post :create_delegate_parent, params
		assert_redirected_to delegate_parent_user_path(u)
		assert_not_nil flash[:error], "Nothing in flash"
	end

	test "create delgate parent" do
		u = users(:juana_senior)
		sign_in u

		joe = users(:joe)

		assert_difference "joe.children.count", 2 do
			params = {
			:id => u.id,
			:email => joe.email,
				:user_ids => u.children.each { |x| x.id }
			}
			post :create_delegate_parent, params
			assert_redirected_to edit_user_path(u)
		end
	end

# EDIT USER PROFILE
	test "should redirect to logon if not logged in" do
		get :edit, :id => '0'
		assert_redirected_to new_user_session_path
	end

	test "should error if no id provided" do
		sign_in users(:joe)
		get :edit
		assert_response :error
	end

  test 'edit user' do
    u = users(:joe)
    sign_in u
	 get :edit, :id => u.id
    assert_response :success

		assert_select "a[href$=#{delegate_parent_user_path(u)}]", 1
  end

end
