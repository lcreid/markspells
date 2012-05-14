class PracticeSession < ActiveRecord::Base
  belongs_to :user
  has_many :student_responses, :dependent => :destroy
  belongs_to :word_list
  
  def total_words
    self.word_list.list_items.count
  end

  def words_correct
    self.correct_words.count
  end

  def words_tried
    self.student_responses.collect { |x| x.word_id }.uniq.count
  end
  
  def number_of_tries
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
  
  def complete?
    self.words_left == 0
  end
  
  def duration
    self.student_responses.inject(0.0) { |sum, sr| sum + sr.duration }
  end
  
  # Return ids of correct words
  def correct_words
    self.student_responses.select { |x| x.correct }.collect { |x| x.word_id }.uniq
  end

  def remaining_words_in_list
#    ListItem
#    .where(:word_list_id => word_list_id)
#    .where("not exists (select * from student_responses sr where list_items.id = sr.word_id and sr.user_id = ? and correct = ?)",
#    user_id,
#    true)
#    .order(:word_order).all
    self.word_list.list_items.reject { |x| correct_words.include? x.id }
  end

  def next_word_not_yet_answered_correctly(current_word)
   	candidate_words = self.remaining_words_in_list
#		puts "Incorrect words: ", candidate_words.count.to_s
		
		candidate_words = word_list.all_words_in_list if candidate_words.empty?
#		puts "Candidate words: ", candidate_words.to_s
		
#		w = candidate_words.find(lambda { candidate_words.first } ) { |w| self.word_order < w.word_order }
#		puts "Returning: ", w.inspect
		
		candidate_words.find(lambda { candidate_words.first } ) { |w| current_word.word_order < w.word_order }
  end

  def to_s
    "User: #{user.name} Word List: #{word_list.title}"
  end
end
