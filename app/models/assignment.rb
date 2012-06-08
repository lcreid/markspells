class Assignment < ActiveRecord::Base
  belongs_to :word_list
  belongs_to :assigned_to, :class_name => "User", :foreign_key => :assigned_to_id
  belongs_to :assigned_by, :class_name => "User", :foreign_key => :assigned_by_id

	def practice_sessions
		self.assigned_to.practice_sessions.select { |x| x.word_list_id == self.word_list_id }
	end
	
  def n_tries
    return self.practice_sessions.count
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
  
  def incomplete?
    not self.complete?
  end
  
  def complete?
    self.practice_sessions.any? { |x| x.complete? }
  end
  
  def to_s
    "User: #{assigned_to.name} Word List: #{word_list.title}"
 end

	def goal
		# TODO: this needs to be elaborated
		"Complete once"
	end
	
	def achieved?
		self.complete?
	end
	
	def duration
		# .select(:word_list_id => self.word_list.id)
		self.practice_sessions.inject(0) { |sum, ps| sum + ps.duration }
	end
	
end
