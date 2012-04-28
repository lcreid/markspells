class WordList < ActiveRecord::Base
  has_many :list_items, :order => "word_order"
  accepts_nested_attributes_for :list_items, :reject_if => lambda { |w| w[:word].blank? }, :allow_destroy => true
  has_many :assignments
  has_many :assigned_to, :through => :assignments, :order => :name

  def all_words_in_list
    list_items
  end

  def remaining_words_in_list(user_id)
    User.find(user_id).current_practice_session.remaining_words_in_list
  end

#  def title
#    #  		puts "word_list.id = ", @id.to_s
#    return "Oops. No words in list. (WordList.title)" if list_items.empty?
#    list_items.first.word
#  end

  def for_study(n_cols)
    n_rows = (list_items.count.to_f / n_cols).ceil
    words = []
    row = 0
    n_empties = n_rows * n_cols - list_items.count
    list_items.inject(0) do |i,w|
      row = 0 if i % n_rows == 0
#      printf("row %d col %d i %d n_rows %d\n", row, col, i, n_rows)
      words << Array.new if i < n_rows
      words[(i % n_rows).truncate] << w.word if w.word
      row += 1
      i + 1
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

