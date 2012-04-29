module OldUserHelper
	def old_current_user_id
		# This is bogus to use a guid and then just turn it into an int, but until I have a user model
		# this should be good enough.
		# current_user_id_internal.to_s.each_char.inject(0) { |i, c| i += c.to_i(16) }
		old_current_user.id
	end
	
	def old_current_user
#	  cookie = old_current_user_id_internal
#	  OldUser.where(:user_guid => cookie.to_s).first_or_create
    current_or_guest_user
	end
	
	def old_current_user_id_internal
		cookies.permanent[:old_current_user] = { :value => Guid.new } if cookies[:old_current_user].nil?
		cookies[:old_current_user]
	end


  # From devise: https://github.com/plataformatec/devise/wiki/How-To:-Create-a-guest-user
  # Modified to maintain unique guest users.
  # TODO: Have guest user become real user -- that will be advanced...
  
  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        logging_in
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  end

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
  end

  private

  def create_guest_user
#    u = User.create(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(99)}@example.com")
    # TODO: Put name (nick_name) back in here
    guid = Guid.new
#    u = User.create(:name => "guest", :email => "guest_#{guid}@example.com", :user_guid => guid)
    u = User.create(:email => "guest_#{guid}@example.com")
    u.save(:validate => false)
    u
  end
end
