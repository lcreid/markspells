require 'test_helper'

class WordListControllerTest < ActionController::TestCase
  test "get the list of word lists as an anonymous user" do
    get :index
    assert_response :success

    assert_select( 'div#word-list-list', nil, "Missing word lists") do
      assert_select( 'table#word-list', nil, "Missing word list table") do
        assert_select 'tr' do |row|
          assert_select row[1], 'td' do |col|
            assert_select col[4], 'td' do
              assert_select 'a', 'Practice', "Missing or incorrect practice link"
            end
            assert_select col[5], 'td' do
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

    assert_select 'a', 'Practice this list', "Missing or incorrect practice link"
    assert_select 'a', "Back to all lists",  "Missing or incorrect all lists link."
  end

end
