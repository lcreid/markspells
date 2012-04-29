module OldUserHelper
	def old_current_user_id
		# This is bogus to use a guid and then just turn it into an int, but until I have a user model
		# this should be good enough.
		# current_user_id_internal.to_s.each_char.inject(0) { |i, c| i += c.to_i(16) }
		old_current_user.id
	end
	
	def old_current_user
	  cookie = old_current_user_id_internal
	  OldUser.where(:user_guid => cookie.to_s).first_or_create
	end
	
	def old_current_user_id_internal
		cookies.permanent[:old_current_user] = { :value => Guid.new } if cookies[:old_current_user].nil?
		cookies[:old_current_user]
	end
end
