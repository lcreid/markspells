class WordList < ActiveRecord::Base
  has_many :list_items, :order => "word_order"
  accepts_nested_attributes_for :list_items, :reject_if => lambda { |w| w[:word].blank? }, :allow_destroy => true
  has_many :assignments
  has_many :assigned_to, :through => :assignments, :order => :name
  belongs_to :user
  
  default_scope :order => 'due_date desc'

  def all_words_in_list
    list_items
  end

  def remaining_words_in_list(user_id)
    OldUser.find(user_id).current_practice_session.remaining_words_in_list
  end

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
