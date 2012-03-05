class StudentResponse < ActiveRecord::Base
  validates :user_id, :presence => { :message => "Missing user_id" }
  validates :word_id, :presence => { :message => "Missing word_id" }

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

end
