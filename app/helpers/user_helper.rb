module UserHelper
	def current_user_id
		# This is bogus to use a guid and then just turn it into an int, but until I have a user model
		# this should be good enough.
		# current_user_id_internal.to_s.each_char.inject(0) { |i, c| i += c.to_i(16) }
		current_user.id
	end
	
	def current_user
	  cookie = current_user_id_internal
	  User.where(:user_guid => cookie.to_s).first_or_create
	end
	
	def current_user_id_internal
		cookies.permanent[:current_user] = { :value => Guid.new } if cookies[:current_user].nil?
		cookies[:current_user]
	end
end
