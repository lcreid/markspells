class User < ActiveRecord::Base
  has_many :student_responses
  has_many :practice_sessions
  has_many :word_lists, :through => :assignments
  
  # TODO: Test that this really works when there are different word lists.
  def all_results(word_list_id)
    self.practice_sessions.collect { |x| x.word_list_id == word_list_id }
  end
  
  def current_practice_session
    self.practice_sessions.last
  end
  
  def complete(word_list_id)
    return self.practice_sessions.select { |ps| 
      ps.word_list_id == word_list_id && ps.complete?
    }
  end

  def reset
    self.practice_sessions.build(:word_list_id => self.current_practice_session.word_list_id)
  end
end
