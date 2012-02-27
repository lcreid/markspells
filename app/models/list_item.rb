class ListItem < ActiveRecord::Base
	validates :word, :presence => true
	#~ validates :sentence, :presence => true
		
	def next
		i = ListItem.where("word_order > ?", self.word_order).order("word_order").limit(1)[0]
		i = ListItem.first(:order => "word_order") if i.nil?
		return i
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
		
		#~ def self.first
			#~ ListItem.where("word_order = 0").limit(1)[0]
		#~ end
				
end
