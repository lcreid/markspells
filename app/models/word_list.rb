class WordList < ActiveRecord::Base
  has_many :list_items, :order => "word_order"
  accepts_nested_attributes_for :list_items # , :allow_destroy => true

  def all_words_in_list
    list_items
  end

  def remaining_words_in_list(user_id)
    ListItem
    .where(:word_list_id => self.id)
    .where("not exists (select * from student_responses sr where list_items.id = sr.word_id and sr.user_id = ? and correct = ?)",
    user_id,
    true)
    .order(:word_order).all
  end

  def title
    #  		puts "word_list.id = ", @id.to_s
    return "Oops. No words in list. (WordList.title)" if list_items.empty?
    list_items.first.word
  end

  def for_study(n_cols)
    n_rows = (list_items.count.to_f / n_cols).ceil
    #  	puts "Dimensions: " + n_rows.to_s + "X" + n_cols.to_s
    words = []
#    list_items.sort! { |a,b| a.word_order <=> b.word_order }
    list_items.inject(0) do |i,w|
      words << Array.new if i < n_rows
      #  		puts i.to_s + ": " + w.word,
      #  			"Put in row: " + (i % n_rows).truncate.to_s + " col: " + (i / n_rows).to_s

      words[(i % n_rows).truncate][i / n_rows] = w.word
      #  		words[((i % n_rows).truncate * n_cols) + (i % n_cols).truncate] = w.word
      i += 1
    end
    words
  end

end
#  attr_accessor :id
#
#  def initialize(id)
#    @id = id
#  end
#
#  def all_words_in_list
#    ListItem.find_all_by_word_list_id(@id)
#  end
#
#
#  def remaining_words_in_list(user_id)
#    ListItem
#    .where(:word_list_id => @id)
#    .where("not exists (select * from student_responses sr where list_items.id = sr.word_id and sr.user_id = ? and correct = ?)",
#    user_id,
#    true).all
#  end
#
#  def title
#    #  		puts "word_list.id = ", @id.to_s
#    ListItem.find_by_word_list_id(@id).word || "Can't Happen!!!"
#  end
#
#  def self.all
#    word_lists = []
#    ListItem.select(:word_list_id).uniq.all.each do |wid|
#      word_lists << WordList.new(wid.word_list_id)
#    end
#    word_lists
#  end
#end

