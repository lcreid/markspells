class User < ActiveRecord::Base
  has_many :student_responses
  has_many :practice_sessions
  
  # TODO: Test that this really works when there are different word lists.
  def all_results(word_list_id)
    self.practice_sessions.collect { |x| x.word_list_id == word_list_id }
  end
  
  def current_practice_session
    self.practice_sessions.last
  end
end
