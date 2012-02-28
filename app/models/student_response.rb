class StudentResponse < ActiveRecord::Base
	validates :user_id, :presence => true
		
		def check
			return self.correct = false if self.student_response.nil?
			self.correct = (self.word.casecmp(self.student_response.nil? ? "" : self.student_response ) == 0)
		end
		
		def correct
			self.check if read_attribute(:correct).nil?
			super()
		end
		
		def student_response=(word)
			super(word)
			self.check
			word
		end
			
end
