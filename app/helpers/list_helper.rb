module ListHelper
class ListStats
	def initialize(user_id)
		@user_id = user_id
	end
	
	def total_words
		ListItem.all.count
	end
	
	def words_correct
		# TODO: Should the following be word_id? 
		# Not yet, because I don't always bother to set word_id.
		# In the future, quite possibly
		StudentResponse.select(:word).where(:user_id => @user_id).where(:correct => true).count(:distinct => true)
	end
	
	def words_tried
		# TODO: Should the following be word_id? 
		# Not yet, because I don't always bother to set word_id.
		# In the future, quite possibly
		StudentResponse.select(:word).where(:user_id => @user_id).count(:distinct => true)
	end
		
	def words_untried
		total_words - words_tried
	end
	
	def words_left
		total_words - words_correct
	end
	
	def reset
		StudentResponse.where(:user_id => @user_id).each { |r| r.destroy }
	end
	
end
end
