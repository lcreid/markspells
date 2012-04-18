require 'test_helper'

class WordListsControllerTest < ActionController::TestCase
  test "get the list of word lists as an anonymous user" do
    get :index
    assert_response :success

    assert_select( 'div#word-list-list', nil, "Missing word lists") do
      assert_select( 'table#word-list', nil, "Missing word list table") do
        assert_select 'tr' do |row|
          assert_select row[1], 'td' do |col|
            assert_select col[1], 'td', '2012-04-11', "Missing or incorrect due date."
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
    assert_select 'a', "Back to all lists",  "Missing or incorrect all lists link."
  end

  test "should fail to get cuadrant for id" do
    # get on this always needs to know the results we're working on,
    # so this has to fail
    get :cuadrant
    assert_response :error
  end
  
  test "basic test four cuadrants with id" do
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
    get :edit, :id => word_lists(:one)
    assert_response :success 
  end
  
  test "post update" do 
    id = word_lists(:short_list_for_update).id
    params = {
      :id => id, 
      :word_list => { 
        :title => "New Update Test Title", 
        :due_date => '2011-05-02', 
        :list_items => { 
          list_items(:short_list_for_update_1).id => {
            :word => 'aa', 
            :sentence => 'this has aa.'
          }
        }
      }
    }
    post :update, params
    # this one stays on itself so you can save and continue updating.
    # TODO: I'll have to provide a way to navigate off
    assert_redirected_to word_list_path :id => id
  end
  
  test "post create" do 
    params = {
      :word_list => { :title => "Newly Created Title", :due_date => '2011-05-02' } #S{ :word => 'a', :sentence => 'this has a.'}
    }
    assert_difference 'WordList.all.count', 1 do
      post :create, params
    end
  end
  
  test "new" do 
    get :new
    assert_response :success
  end

	test "must specify a list" do
	  assert_raise(RuntimeError) do 
		  get :practice
	  end
	end
		
	test "practice a list" do
		get :practice, :id => word_lists(:two).id
		assert_redirected_to practice_list_item_path(ListItem.
		  where(:word_list_id => word_lists(:two).id).
		  first(:order => "word_order"))
	end
		
end
