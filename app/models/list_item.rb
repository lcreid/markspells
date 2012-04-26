class ListItem < ActiveRecord::Base
	include ListHelper
	
	belongs_to :word_list
	
  validates :word, :presence => { :message => ": missing." }
  validates :word_order, :presence => { :message => ": missing." }
  #~ validates :sentence, :presence => true

  def next_word_not_yet_answered_correctly(user_id)
    puts "IN NEXT_WORD_NOT_YET..." + User.find(user_id).current_practice_session.student_responses.to_s
  	candidate_words = word_list.remaining_words_in_list(user_id)
#		puts "Remaining words: ", candidate_words.count.to_s
		
		candidate_words = word_list.all_words_in_list if candidate_words.empty?
#		puts "Candidate words: ", candidate_words.to_s
		
#		candidate_words.sort! { |a,b| a.word_order <=> b.word_order }
#		puts "Sorted candidate words: ", candidate_words.to_s
		
#		w = candidate_words.find(lambda { candidate_words.first } ) { |w| self.word_order < w.word_order }
#		puts "Returning: ", w.inspect
		
		candidate_words.find(lambda { candidate_words.first } ) { |w| self.word_order < w.word_order }
  end

  def sentence_without_word
    self.sentence.gsub(/\b#{self.word}\b/i, ' ' * self.word.length) if ! self.sentence.nil?
  end

  def beginning_of_sentence
    self.sentence.gsub(/\b#{self.word}\b.*/i, "") if ! self.sentence.nil?
  end

  def end_of_sentence
    self.sentence.gsub(/.*\b#{self.word}\b/i, "") if ! self.sentence.nil?
  end

  def verbal_prompt
    p = self.word + ". \n"
    p += self.sentence + " \n" if self.sentence
    p += self.word + ". "
  end

  #~ def self.first
  #~ ListItem.where("word_order = 0").limit(1)[0]
  #~ end

end
