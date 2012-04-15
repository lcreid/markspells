class PracticeSession < ActiveRecord::Base
  belongs_to :user
  has_many :student_responses
  
  def total_words
    ListItem.where(:word_list_id => self.word_list_id).count
  end

  def words_correct
#    StudentResponse.select(:word_id).where(:user_id => self.user_id).where(:correct => true).count(:distinct => true)
    self.student_responses.select { |x| x.correct }.collect { |x| x.word_id }.uniq.count
  end

  def words_tried
#    StudentResponse.select(:word_id).where(:user_id => self.user_id).count(:distinct => true)
    self.student_responses.collect { |x| x.word_id }.uniq.count
  end
  
  def number_of_tries
#    StudentResponse.select(:word_id).where(:user_id => self.user_id).count
    self.student_responses.count
  end
  
  def missed
    self.number_of_tries - self.words_correct
  end

  def words_untried
    total_words - words_tried
  end

  def words_left
    total_words - words_correct
  end
  
  def duration
    # This is a really bogus way to calculate this.
    # I should be testing how long they stare at each word.
    # TODO: Make some tests that really test duration.
    return 0.0 if student_responses.empty?
    start_end = student_responses.minmax_by { |x| x.created_at }
    start_end[1].created_at - start_end[0].created_at
  end

#  def reset
##    StudentResponse.where(:user_id => self.user_id).each { |r| r.destroy }
#    self.user.practice_sessions.create(:word_list_id => self.word_list_id)
#  end
end
