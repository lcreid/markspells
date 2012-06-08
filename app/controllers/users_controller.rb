class UsersController < ApplicationController
  before_filter :authenticate_user!
  
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