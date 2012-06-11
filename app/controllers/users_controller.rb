class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /users/1/delegate_parent
  def delegate_parent
    render :text => 'Internal error: missing id', :status => 500 and return unless params[:id]
    @user = User.find(params[:id])
  end

  # PUT /users/1/create_delegate_parent
  # PUT /users/1/create_delegate_parent.json
  def create_delegate_parent
		logger.debug "create_delegate_parent: #{params.inspect}"
		
    render :text => 'Internal error: missing id', :status => 500 and return unless params[:id] && params[:email]
		
		@user = User.find(params[:id])
		
		if params[:email].empty?
			flash[:error] = "Please enter an e-mail address."
		else
			flash[:error] = "User with e-mail '#{ params[:email] }' is not in our database. " + 
				"Please check the spelling and try again." unless other_parent = User.find_by_email(params[:email])
		end
		
		redirect_to delegate_parent_user_path(@user) and return unless flash[:error].nil? || flash[:error].empty?
				
    respond_to do |format|
      if other_parent.add_children(params[:user_ids])
        format.html { redirect_to edit_user_path(@user), notice: 'Children added to other parent.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /users/1/edit
  def edit
    render :text => 'Internal error: missing id', :status => 500 and return unless params[:id]
    @user = User.find(params[:id])
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    logger.debug "UPDATING params: " + params.inspect
    
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params)
        format.html { redirect_to edit_user_path(:id => @user.id), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end