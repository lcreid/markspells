class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :user_guid

  has_many :student_responses
  has_many :practice_sessions, :dependent => :destroy
  has_many :assignments, :foreign_key => :assigned_to_id

  # It looks like I didn't need the following. I think my intent was that it would have been the lists
  # assigned to the person. It might not have even worked, because the key fields in assignment
  # need to be specified.
  #~ has_many :word_lists, :through => :assignments
  # The following is the word lists that this user has created
  has_many :word_lists
  has_many :assigned_by_me, :class_name => 'Assignment', :foreign_key => :assigned_by_id

  has_many :passoc, :class_name => "ChildParent", :foreign_key => :parent_id
  has_many :cassoc, :class_name => "ChildParent", :foreign_key => :child_id
  has_many :parents, :class_name => "User", :through => :cassoc
  has_many :children, :class_name => "User", :through => :passoc

  belongs_to :invitor, :class_name => "User", :foreign_key => :invitor_id

	# Ad an array of hild ids to a user
	def add_children(child_ids)
		child_ids.each do |child_id|
			self.passoc.create(:child_id => child_id)
		end
	end

  # Return an array of assignments for children of (Ruby) self that are assigned to the given word list
	def children_assigned_to(word_list_id, reload = false)
		#~ logger.debug "************ #{ self.name }: in children_assigned_to(#{word_list_id.to_s})"
		#~ logger.debug "************ All Assignments: #{ Assignment.all.inspect }"
		#~ logger.debug "************ All Children: #{ self.children.inspect }"
		#~ logger.debug "************ Assignments of each child: #{ self.children.collect { |c| c.assignments.inspect } }"
		self.children(reload).collect { |c| c.assignments.any? { |a| a.word_list_id == word_list_id } }
		WordList.find(word_list_id).assignments.select { |a| self.children(reload).any? { |c| a.assigned_to_id == c.id }}
		#~ c = self.children.select do |c|
			#~ logger.debug c.inspect
			#~ c.assignments.any? do |a|
				#~ logger.debug "word_list_id is: #{word_list_id}, #{a.inspect}, #{(a.word_list_id == word_list_id).to_s}"
				#~ logger.debug "word_list_id is: #{word_list_id} (#{word_list_id.class}), a.word_list_id is: #{a.word_list_id} (#{a.word_list_id.class})"
				#~ a.word_list_id == word_list_id
			#~ end
		#~ end
	end

  # Return an array of users who are children of (Ruby) self and are not assigned to the given word list
  def children_unassigned_to(word_list_id, reload = false)
	  self.children(reload).select { |c| c.assignments.none? { |a| a.word_list_id == word_list_id } }
  end

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
    self.practice_sessions.create(:word_list_id => self.current_practice_session.word_list_id)
  end

  def overdue_assignments
    self.incomplete_assignments.select { |x| x.word_list.due_date < Date.today }
  end

  def not_due_assignments
    self.incomplete_assignments.select { |x| Date.today <= x.word_list.due_date }
  end

  def coming_soon_assignments(window = Date.today - 2.days)
    self.not_due_assignments.select { |x| window <= x.word_list.due_date }
  end

  def incomplete_assignments
    self.assignments.select { |x| x.incomplete? }.sort { |a,b| b.word_list.due_date <=> a.word_list.due_date }
  end

  def complete_assignments
    self.assignments.select { |x| x.complete? }.sort { |a,b| b.word_list.due_date <=> a.word_list.due_date }
  end

  # From https://github.com/plataformatec/devise/wiki/How%20To:%20Email-only%20sign-up
  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

end
