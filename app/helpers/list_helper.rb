module ListHelper
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

  class WordList
  	attr_reader :id
  	
    def initialize(id)
      @id = id
    end

    def all_words_in_list
      ListItem.find_all_by_word_list_id(@id)
    end


    def remaining_words_in_list(user_id)
      ListItem
      .where(:word_list_id => @id)
      .where("not exists (select * from student_responses sr where list_items.id = sr.word_id and sr.user_id = ? and correct = ?)",
      user_id,
      true).all
    end
  	
  	def title
#  		puts "word_list.id = ", @id.to_s
  		ListItem.find_by_word_list_id(@id).word || "Can't Happen!!!"
  	end
  end
  
  class WordLists
    def initialize(id)
      @id = id
    end

  	def self.all
  		word_lists = []
  		ListItem.select(:word_list_id).uniq.all.each do |wid|
  			word_lists << WordList.new(wid.word_list_id)
  		end
  		word_lists
  	end
  end
end
