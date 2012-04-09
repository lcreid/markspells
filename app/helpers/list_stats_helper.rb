module ListStatsHelper
  class ListStats
  	attr_reader :user_id, :word_list_id
  	
    def initialize(user_id, word_list_id)
      @user_id = user_id
      @word_list_id = word_list_id
    end

    def total_words
      ListItem.where(:word_list_id => @word_list_id).count
    end

    def words_correct
      StudentResponse.select(:word_id).where(:user_id => @user_id).where(:correct => true).count(:distinct => true)
    end

    def words_tried
      StudentResponse.select(:word_id).where(:user_id => @user_id).count(:distinct => true)
    end
    
    def number_of_tries
      StudentResponse.select(:word_id).where(:user_id => @user_id).count
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
      all_responses = StudentResponse.where(:user_id => @user_id)
      return 0.0 if all_responses.empty?
      start_end = all_responses.minmax_by { |x| x.created_at }
      start_end[1].created_at - start_end[0].created_at
    end

    def reset
      StudentResponse.where(:user_id => @user_id).each { |r| r.destroy }
    end

  end
end
