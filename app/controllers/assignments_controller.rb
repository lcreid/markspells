class AssignmentsController < ApplicationController
  before_filter :authenticate_user!
  
	def index
		logger.debug "***************" + params.inspect
		render :text => 'Internal error: missing word_list_id', :status => 500 and return unless params[:word_list_id]
		# TODO: Figure out why when I use this, I have to deal with params[:id] being a string...
		word_list_id = params[:word_list_id].to_i
		@word_list = WordList.find(word_list_id)
		@assigned = current_user.children_assigned_to(word_list_id)
		@unassigned = current_user.children_unassigned_to(word_list_id)
	end

	def create
		logger.debug "***************" + params.inspect
		render :text => 'Internal error: missing parameters', :status => 500 and 
			return unless params[:word_list_id] && 
				params[:user_ids] 
		word_list = WordList.find(params[:word_list_id])
		params[:user_ids].each do |uid| 
			word_list.assignments.create(:assigned_to_id => uid, :assigned_by_id => current_user.id) 
		end
		
		render :nothing => true
		#~ render :nothing => true and return if word_list.assignments.create(params[:assignment])
		#~ flash[:error] = 'Internal error: Failed to create assignment.' 
		#~ redirect_to :back
	end
	
	def destroy
		logger.debug "***************" + params.inspect
		render :text => 'Internal error: missing parameters', :status => 500 and 
			return unless params[:word_list_id] && 
				params[:assignment_ids] 
		word_list_id = params[:word_list_id].to_i
		params[:assignment_ids].each do |a|
			Assignment.find(a).destroy
		end
		
		render :nothing => true
		#~ render :nothing => true and return if a.destroy
		#~ flash[:error] = 'Internal error: Failed to destroy assignment.' 
		#~ redirect_to :back
	end
 		
end