class StudentResponse < ActiveRecord::Base
  validates :user_id, :presence => { :message => "Missing user_id" }
  validates :word_id, :presence => { :message => "Missing word_id" }
  
  belongs_to :user
  belongs_to :list_item, :foreign_key => :word_id
  has_one :word_list, :through => :list_item

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
    list(criteria) { |missed_avg, time_avg, us| us.missed <= missed_avg && us.duration <= time_avg }
  end
  
  def self.red_list(criteria)
    list(criteria) { |missed_avg, time_avg, us| missed_avg < us.missed && us.duration <= time_avg }
  end
  
  def self.orange_list(criteria)
    list(criteria) { |missed_avg, time_avg, us| us.missed <= missed_avg && time_avg < us.duration }
  end
  
  def self.yellow_list(criteria)
    list(criteria) { |missed_avg, time_avg, us| missed_avg < us.missed && time_avg < us.duration }
  end
  
  private
  def self.list(criteria)
    list = StudentResponse.all(:joins => :list_item, :conditions => {:list_items => criteria})
    return list if list.empty?
#    puts "Raw list: " + list.inspect
    # Group by student,
    # ratio of tries to correct below average
    # time from start to finish below average
    user_stats = []
    missed_sum = time_sum = 0
    list.collect{ |x| { :user_id => x.user_id, :word_list_id => x.word_list.id } }.uniq.each do |u|
      ls = ListStatsHelper::ListStats.new(u[:user_id], u[:word_list_id])
      missed_sum += ls.missed
      time_sum += ls.duration
#      print "List stats: " + ls.to_s
      user_stats << ls
    end
#    puts "User stats size: " + user_stats.size.to_s
    missed_avg = missed_sum / user_stats.size
    time_avg = time_sum / user_stats.size
    users = []
    user_stats.each do |us|
      if yield(missed_avg, time_avg, us)
        users << User.find(us.user_id)
      end
    end
#    puts users
    users
  end
end
