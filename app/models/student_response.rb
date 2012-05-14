class StudentResponse < ActiveRecord::Base
  validates :word_id, :presence => { :message => "Missing word_id" }
  
  belongs_to :user
  belongs_to :practice_session
  belongs_to :list_item, :foreign_key => :word_id

	def duration
		return 0.0 if self.start_time.nil? || self.end_time.nil?
		self.end_time - self.start_time
	end
	
  def check
    return self.correct = false if self.student_response.nil?
    self.correct = (self.word.casecmp(self.student_response.nil? ? "" : self.student_response ) == 0)
  end

  def correct
    self.check if read_attribute(:correct).nil?
    super()
  end

  def student_response=(word)
  	word.strip!
    super(word)
    self.check
    word
  end
  
  # Return the list of users who are green
  def self.green_list(criteria)
    whats_your_colour(criteria) { |missed_avg, time_avg, missed, duration| missed <= missed_avg && duration <= time_avg }
  end
  
  def self.red_list(criteria)
    whats_your_colour(criteria) { |missed_avg, time_avg, missed, duration| missed_avg < missed && duration <= time_avg }
  end
  
  def self.orange_list(criteria)
    whats_your_colour(criteria) { |missed_avg, time_avg, missed, duration| missed <= missed_avg && time_avg < duration }
  end
  
  def self.yellow_list(criteria)
    whats_your_colour(criteria) { |missed_avg, time_avg, missed, duration| missed_avg < missed && time_avg < duration }
  end
  
  private
  def self.whats_your_colour(criteria)
    list = StudentResponse.all(:joins => :list_item, :conditions => {:list_items => criteria})
    return [] if list.empty?
    
#    puts "Raw list: " + list.inspect
    # Group by student,
    user_stats = {}
    missed_sum = time_sum = 0
    list.each do |sr|
      user_stats[sr.user_id] = { :missed_sum => 0, :time_sum => 0 } unless user_stats[sr.user_id]
      
      if ! sr.correct
        missed_sum += 1
        user_stats[sr.user_id][:missed_sum] += 1
      end
      
      time_sum += sr.duration
      user_stats[sr.user_id][:time_sum] += sr.duration
    end
    
    return [] if user_stats.empty?
    
#    puts "User stats size: " + user_stats.size.to_s
    missed_avg = missed_sum / user_stats.size
    time_avg = time_sum / user_stats.size
    
#    puts "********* missed_avg: " + missed_avg.to_s + " time_avg: " + time_avg.to_s
    
    users = []
    user_stats.each do |uid, values|
      if yield(missed_avg, time_avg, values[:missed_sum], values[:time_sum])
        users << User.find(uid)
      end
    end
#    puts users
    users
  end
end
