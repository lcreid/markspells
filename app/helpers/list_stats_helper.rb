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
