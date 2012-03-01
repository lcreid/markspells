class ListItem < ActiveRecord::Base
	include ListHelper
	
	belongs_to :word_list
	
  validates :word, :presence => { :message => ": missing." }
  validates :word_list_id, :presence => { :message => ": missing." }
  #~ validates :sentence, :presence => true

  def next_word_not_yet_answered_correctly(user_id)
  	word_list = WordList.find(word_list_id)
  	candidate_words = word_list.remaining_words_in_list(user_id)
#		puts "Incorrect words: ", candidate_words.count.to_s
		
		candidate_words = word_list.all_words_in_list if candidate_words.empty?
#		puts "Candidate words: ", candidate_words.to_s
		
		candidate_words.sort! { |a,b| a.word_order <=> b.word_order }
#		puts "Sorted candidate words: ", candidate_words.to_s
		
#		w = candidate_words.find(lambda { candidate_words.first } ) { |w| self.word_order < w.word_order }
#		puts "Returning: ", w.inspect
		
		candidate_words.find(lambda { candidate_words.first } ) { |w| self.word_order < w.word_order }
#    i = ListItem.where("word_order > ?", self.word_order)
#    	.where("not exists (select * from student_responses sr where list_items.id = sr.word_id and sr.user_id = ? and correct = ?)", 
#    		user_id,
#    		true)
#    	.order("word_order")
#    	.first
#    i = ListItem.first(:order => "word_order") if i.nil?
#    return i
  end

  def sentence_without_word
    self.sentence.gsub(/\b#{self.word}\b/, ' ' * self.word.length) if ! self.sentence.nil?
  end

  def beginning_of_sentence
    self.sentence.gsub(/\b#{self.word}\b.*/, "") if ! self.sentence.nil?
  end

  def end_of_sentence
    self.sentence.gsub(/.*\b#{self.word}\b/, "") if ! self.sentence.nil?
  end

  def verbal_prompt
    p = self.word
    p += ". " + self.sentence + " " if self.sentence
    p += self.word + ". "
  end

  #~ def self.first
  #~ ListItem.where("word_order = 0").limit(1)[0]
  #~ end

end
