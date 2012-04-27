class ListItem < ActiveRecord::Base
	include ListHelper
	
	belongs_to :word_list
	
  validates :word, :presence => { :message => ": missing." }
  validates :word_order, :presence => { :message => ": missing." }
  #~ validates :sentence, :presence => true

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
