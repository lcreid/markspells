module ListHelper
class ListStats
	def setup
		StudentResponse.all.destroy
	end
		
	def total_words
		ListItem.all.count
	end
	
	def words_correct
		# TODO: Should the following be word_id? 
		# Not yet, because I don't always bother to set word_id.
		# In the future, quite possibly
		StudentResponse.select(:word).where(:correct => true).count(:distinct => true)
	end
	
	def words_tried
		# TODO: Should the following be word_id? 
		# Not yet, because I don't always bother to set word_id.
		# In the future, quite possibly
		StudentResponse.select(:word).count(:distinct => true)
	end
		
	def words_untried
		total_words - words_tried
	end
	
	def words_left
		total_words - words_correct
	end
	
end
end
