class User < ActiveRecord::Base
  has_many :student_responses
end
