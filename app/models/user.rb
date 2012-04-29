class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :user_guid

  has_many :student_responses
  has_many :practice_sessions, :dependent => :destroy
  has_many :assignments, :foreign_key => :assigned_to_id
  has_many :word_lists, :through => :assignments
  
  # TODO: Test that this really works when there are different word lists.
  def all_results(word_list_id)
    self.practice_sessions.collect { |x| x.word_list_id == word_list_id }
  end
  
  def current_practice_session
    self.practice_sessions.last
  end
  
  def complete(word_list_id)
    return self.practice_sessions.select { |ps| 
      ps.word_list_id == word_list_id && ps.complete?
    }
  end

  def reset
    self.practice_sessions.build(:word_list_id => self.current_practice_session.word_list_id)
  end
end
