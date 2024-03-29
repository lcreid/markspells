require 'test_helper'

class WordListsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "get list_complete page" do
	  u = users(:short_list_student)
	  sign_in u
	  word_list = u.assignments.first.word_list
	  get :list_complete, :id => word_list.id
	  assert :success
	  
	  assert_select "div#list-complete", 1 do
		  assert_select "a[href$=#{root_path}]", 1
		  assert_select "a[href$=#{practice_word_list_path(word_list)}]", 1
	  end
	  
  end
  
  test "get list_complete redirects to sign-in page" do
	  get :list_complete, :id => 0
		assert_redirected_to new_user_session_path
  end
  
  test "get list_complete redirects to error page" do
	  u = users(:short_list_student)
	  sign_in u
	  get :list_complete
		assert :error
  end
  
	test "assign_many an assignment" do
		u = users(:juana_senior)
		sign_in u
		word_list = u.word_lists.first

		params = { 
			:id => word_list.id, 
			:user_ids => [ users(:one_mixed).id	]
		}
		assert_difference "u.children_assigned_to(word_list.id, true).count", 1, "An assignment should be created" do
			post :assign_many, params
			assert_redirected_to maintain_assignments_word_list_path(word_list.id)
		end
	end
  
	#~ test "js assign_many an assignment" do
		#~ u = users(:juana_senior)
		#~ sign_in u
		#~ word_list = u.word_lists.first

		#~ params = { 
			#~ :id => word_list.id, 
			#~ :user_ids => [ users(:one_mixed).id	]
		#~ }
		#~ assert_difference "u.children_assigned_to(word_list.id, true).count", 1, "An assignment should be created" do
			#~ @controller.logger.debug "js assign many"
			#~ post :assign_many, params, :format => 'js'
			#~ assert_redirected_to maintain_assignments_word_list_path(word_list.id)
		#~ end
	#~ end
  
	test "assign_many redirects to login page" do
		params = { 
			:id => 0, 
			:user_ids => [ users(:one_mixed).id	]
		}
		post :assign_many, params
		assert_redirected_to new_user_session_path
	end
  
	test "assign_many errors if no ids" do
		u = users(:juana_senior)
		sign_in u
		word_list = u.word_lists.first

		params = { 
			:user_ids => [ users(:one_mixed).id	]
		}
		post :assign_many, params
		assert_response :error
	end
	
	test "unassign_many an assignment" do
		u = users(:juana_senior)
		sign_in u
		word_list = u.word_lists.first
		
		assert_difference "u.children_assigned_to(word_list.id, true).count", -1, "An assignment should be destroyed" do
			params = { 
				:id => word_list.id, 
				:assignment_ids => [ assignments(:one_each_assignment_coming_soon).id	]
			}
			post :unassign_many, params
			assert_redirected_to maintain_assignments_word_list_path(word_list.id)
		end
	end
	
	#~ test "js unassign_many an assignment" do
		#~ u = users(:juana_senior)
		#~ sign_in u
		#~ word_list = u.word_lists.first
		
		#~ assert_difference "u.children_assigned_to(word_list.id, true).count", -1, "An assignment should be destroyed" do
			#~ params = { 
				#~ :id => word_list.id, 
				#~ :assignment_ids => [ assignments(:one_each_assignment_coming_soon).id	]
			#~ }
			#~ @controller.logger.debug "js unassign many"
			#~ post :unassign_many, params, :format => 'js'
			#~ assert_redirected_to maintain_assignments_word_list_path(word_list.id)
		#~ end
	#~ end
	
	test "unassign_many redirects to login page" do
		params = { 
			#~ :id => word_list.id, 
			:assignment_ids => [ assignments(:one_each_assignment_coming_soon).id	]
		}
		post :unassign_many, params
		assert_redirected_to new_user_session_path
	end
  
	test "unassign_many errors if no ids" do
		u = users(:juana_senior)
		sign_in u
		word_list = u.word_lists.first

		params = { 
			#~ :id => word_list.id, 
			:assignment_ids => [ assignments(:one_each_assignment_coming_soon).id	]
		}
		post :unassign_many, params
		assert_response :error
	end
  
	test "should get maintain_assignments" do
		u = users(:juana_senior)
		sign_in u
		get :maintain_assignments, :id => u.word_lists.first.id
		assert_response :success
		
		assert_select "div#assignment", 1, "Missing assignment div" do
			assert_select "div#assigned", 1, "Missing assigned div" do
				assert_select "input", 1, "Missing assigned person"
				end
			
			assert_select "div#unassigned", 1, "Missing unassigned div" do
				assert_select "input", 1, "Missing user id"
			end
		end
		
		assert_select "a", "Back"
	end
	
	test "should redirect to logon if not logged in" do
		get :maintain_assignments, :id => '0'
		assert_redirected_to new_user_session_path
	end
	
	test "should error if no id provided" do
		sign_in users(:user_for_auth_tests_only)
		get :maintain_assignments
		assert_response :error
	end
	
  test"create a user and put current user ID in it" do
    sign_in users(:joe)
    params = {
      :word_list => { :title => "Test User ID", :due_date => '2011-05-02' } #S{ :word => 'a', :sentence => 'this has a.'}
    }
    assert_difference 'WordList.all.count', 1 do
      post :create, params
      assert_response :redirect
		assert_equal "Test User ID", users(:joe).word_lists[0].title, "Word list not assigned to user."
	end
	end


  test "index redirects to login page" do
    get :index
    assert_redirected_to new_user_session_path
  end
    
  test "study redirects to login page" do
    get :study, :id => word_lists(:one).id
    assert_redirected_to new_user_session_path
  end
    
  test "cuadrant redirects to login page" do
    get :cuadrant, :id => word_lists(:basic_cuadrant_test)
    assert_redirected_to new_user_session_path
  end
    
  test "edit redirects to login page" do
    get :edit, :id => word_lists(:one)
    assert_redirected_to new_user_session_path
  end
    
  test "new redirects to login page" do
    get :new
    assert_redirected_to new_user_session_path
  end
    
  test "practice redirects to login page" do
		get :practice, :id => word_lists(:two).id
    assert_redirected_to new_user_session_path
  end
    
  test "review_assignment redirects to login page" do
  	get :review_assignment, :id => word_lists(:wl_assignment_1)
    assert_redirected_to new_user_session_path
  end
  
  test "update redirects to login page" do
    id = word_lists(:short_list_for_update).id
    params = {
      :id => id, 
      :word_list => { 
        :title => "New Update Test Title", 
        :due_date => '2011-05-02'#, 
      }
    }
    post :update, params
    # this one stays on itself so you can save and continue updating.
    # TODO: I'll have to provide a way to navigate off
    assert_redirected_to new_user_session_path
  end
  
  test "create redirects to login page" do
    params = {
      :word_list => { :title => "Newly Created Title", :due_date => '2011-05-02' } #S{ :word => 'a', :sentence => 'this has a.'}
    }
    post :create, params
    assert_redirected_to new_user_session_path
  end
  
  test "get the list of word lists" do
    sign_in users(:user_for_auth_tests_only)
    get :index
    assert_response :success

    assert_select( 'div#word-list-list', nil, "Missing word lists") do
      assert_select( 'table#word-list', nil, "Missing word list table") do
        assert_select 'tr' do |row|
          assert_select row[5], 'td' do |col|
            assert_select col[1], 'td', nil, "Missing due date."
            assert_select col[5], 'td' do
              assert_select 'a', 'Practice', "Missing or incorrect practice link."
            end
            assert_select col[6], 'td' do
              assert_select 'a', "Study",  "Missing or incorrect study link."
            end
          end
        end
      end
    end
  end

  test "get the study list" do
    sign_in users(:user_for_auth_tests_only)
    get :study, :id => word_lists(:one).id
    assert_response :success

    assert_select( 'div#study-list', nil, "Missing word list div") do
      assert_select( 'table#study-list', nil, "Missing word list table") do
        assert_select 'tr' do |row|
          assert_select row[0], 'td', 3
        end
      end
    end

    assert_select 'a', 'Practice this list', "Missing or incorrect practice link."
    assert_select 'a', "Back",  "Missing or incorrect back link."
  end

  test "should fail to get cuadrant for id" do
    # get on this always needs to know the results we're working on,
    # so this has to fail
    sign_in users(:user_for_auth_tests_only)
    get :cuadrant
    assert_response :error
  end
  
  test "basic test four cuadrants with id" do
    sign_in users(:user_for_auth_tests_only)
    get :cuadrant, :id => word_lists(:basic_cuadrant_test)
    assert_response :success
    
    assert_select 'div#cuadrant-wrapper', nil, "Missing cuadrant-wrapper" do
      assert_select 'div#green-cuadrant', nil, "Missing green-cuadrant" do
        assert_select 'a.student' do |g|
          assert g.detect { |x| x.to_s =~ /.*Cathy Green.*/ }, "Missing or wrong green student"
          assert g.detect { |x| x.to_s =~ /.*Marc Green.*/ }, "Missing or wrong green student"
        end
      end
      assert_select 'div#orange-cuadrant', nil, "Missing orange-cuadrant" do
        assert_select 'a.student' do |g|
          assert g.detect { |x| x.to_s =~ /.*Linda Orange.*/ }, "Missing or wrong green student"
        end
      end
      assert_select 'div#yellow-cuadrant', nil, "Missing yellow-cuadrant" do
        assert_select 'a.student' do |g|
          assert g.detect { |x| x.to_s =~ /.*Nicky Yellow.*/ }, "Missing or wrong green student"
        end
      end
      assert_select 'div#red-cuadrant', nil, "Missing red-cuadrant" do
        assert_select 'a.student' do |g|
          assert g.detect { |x| x.to_s =~ /.*Larry Red.*/ }, "Missing or wrong green student"
        end
      end
    end
  end

  test "get edit" do 
    sign_in users(:user_for_auth_tests_only)
    get :edit, :id => word_lists(:one)
    assert_response :success 
  end
  
  test "post update" do 
    sign_in users(:user_for_auth_tests_only)
    id = word_lists(:short_list_for_update).id
    params = {
      :id => id, 
      :word_list => { 
        :title => "New Update Test Title", 
        :due_date => '2011-05-02'#, 
#        :list_items => { 
#          list_items(:short_list_for_update_1).id => {
#            :word => 'aa', 
#            :sentence => 'this has aa.'
#          }
#        }
      }
    }
    post :update, params
    # this one stays on itself so you can save and continue updating.
    # TODO: I'll have to provide a way to navigate off
    assert_redirected_to edit_word_list_path :id => id
  end
  
  test "post create" do 
    sign_in users(:user_for_auth_tests_only)
    params = {
      :word_list => { :title => "Newly Created Title", :due_date => '2011-05-02' } #S{ :word => 'a', :sentence => 'this has a.'}
    }
    assert_difference 'WordList.all.count', 1 do
      post :create, params
      assert_response :redirect
    end
  end
  
  test "new" do 
    sign_in users(:user_for_auth_tests_only)
    get :new
    assert_response :success
  end

	test "must specify a list" do
    sign_in users(:user_for_auth_tests_only)
	  assert_raise(RuntimeError) do 
		  get :practice
	  end
	end
		
	test "practice a list" do
    sign_in users(:user_for_auth_tests_only)
		get :practice, :id => word_lists(:two).id
		assert_redirected_to practice_list_item_path(ListItem.
		  where(:word_list_id => word_lists(:two).id).
		  first(:order => "word_order"))
	end
	
	test "review a word list" do
    sign_in users(:user_for_auth_tests_only)
  	get :review_assignment, :id => word_lists(:wl_assignment_1)
	  assert_response :success
	  
	  assert_select "p#word-list-title", "Title: Assignment 1\nDue Date: 2012-04-25", "Missing or wrong due date"

    assert_select( 'table#word-list-review', nil, "Missing word list table") do
      assert_select 'tr' do |row|
        assert_select row[0], 'td' do |col|
          assert_select col[0], 'td', "Name"
          assert_select col[1], 'td', "# Tries"
          assert_select col[2], 'td', "# Complete"
          assert_select col[3], 'td', "% Missed"
          assert_select col[4], 'td', "% Missed First"
          assert_select col[5], 'td', "% Missed Last"
          assert_select col[6], 'td', "Improvement"
        end
        assert ! row[1].nil?, "Missing student rows"
        assert_select row[1], 'td' do |col|
          assert_select col[0], 'td', "Joe"
          assert_select col[1], 'td', "3"
          assert_select col[4], 'td', "50"
          assert_select col[5], 'td', "33"
          assert_select col[6], 'td', "17"
          assert_select col[3], 'td', "75"
          assert_select col[2], 'td', "2"
        end
      end
    end
	end
		
end
