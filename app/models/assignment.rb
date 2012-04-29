class Assignment < ActiveRecord::Base
  belongs_to :word_list
  belongs_to :assigned_to, :class_name => "User", :foreign_key => :assigned_to_id
  
  def n_tries
    return self.assigned_to.practice_sessions(:word_list_id => self.word_list_id).count
  end
  def n_complete
    return self.assigned_to.complete(self.word_list_id).count
  end
  def pct_missed
    return nil if self.n_complete == 0
    n = self.assigned_to.complete(self.word_list_id).inject(0) { |i, ps| i + ps.words_tried }
    return nil if n == 0
    return 100 * self.assigned_to.complete(self.word_list_id).inject(0) { |i, ps| i + ps.missed } / n
  end
  def pct_missed_first
    return nil if self.n_complete == 0
    ps = self.assigned_to.complete(self.word_list_id).first
    n = ps.number_of_tries
    return nil if n == 0
    return 100 * ps.missed  / n
  end
  # TODO: DRY this up.
  def pct_missed_last
    return nil if self.n_complete == 0
    ps = self.assigned_to.complete(self.word_list_id).last
    n = ps.number_of_tries
    return nil if n == 0
    return 100 * ps.missed  / n
  end
  def improvement
    return nil if pct_missed_last.nil? || pct_missed_first.nil?
    pct_missed_first - pct_missed_last
  end
end
