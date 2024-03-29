class WordListsController < ApplicationController
  before_filter :authenticate_user!

  # GET /word_lists
  # GET /word_lists.json
  def index
    @word_lists = WordList.order("due_date desc")

#    puts @word_lists.inspect

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @word_lists }
    end
  end

  # GET /word_lists/1/study
  # GET /word_lists/1/study.json
  def study
    @word_list = WordList.find(params[:id])

    respond_to do |format|
      format.html # study.html.erb
      format.json { render json: @word_list }
    end
  end

  def practice
    raise "No list ID provided." unless params[:id]
    @word_list = WordList.find(params[:id])
    u = current_user
    u.practice_sessions.create(:word_list_id => @word_list.id)
		redirect_to(practice_list_item_path(@word_list.list_items.first.id))
	end

  def cuadrant
    # We expect a :criteria hash to tell us what to report on
    render :text => 'Internal error: missing id', :status => 500 and return unless params[:id]
    @green_list = StudentResponse.green_list(:word_list_id => params[:id])
    @orange_list = StudentResponse.orange_list(:word_list_id => params[:id])
    @yellow_list = StudentResponse.yellow_list(:word_list_id => params[:id])
    @red_list = StudentResponse.red_list(:word_list_id => params[:id])
    logger.debug "cuadrant: #{@green_list.count} ********************"
  end

  def review_assignment
    raise "No list ID provided." unless params[:id]
    @word_list = WordList.find(params[:id])
#    puts @word_list.inspect
#    puts @word_list.assigned_to.inspect
  end
#
#  # GET /word_lists/1
#  # GET /word_lists/1.json
#  def show
#    @word_list = WordList.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @word_list }
#    end
#  end
#
#  # GET /word_lists/new
#  # GET /word_lists/new.json
  def new
    @word_list = WordList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @word_list }
    end
  end

  # GET /word_lists/1/edit
  def edit
    @word_list = WordList.find(params[:id])
  end

#  # POST /word_lists
#  # POST /word_lists.json
  def create
    p = self.add_word_order(params)

    logger.debug "CREATING params: " + params.inspect

    @word_list = WordList.new(p[:word_list])
	 @word_list.user_id = current_user.id if current_user

    logger.debug "CREATING: " + @word_list.inspect
    @word_list.list_items.each { |w| logger.debug "\t" + w.inspect }
    logger.debug "VALIDATE: " + @word_list.valid?.to_s

    respond_to do |format|
      if @word_list.save
        format.html { redirect_to edit_word_list_path(:id => @word_list.id), notice: 'Word list was successfully created.' }
        format.json { render json: @word_list, status: :created, location: @word_list }
      else
        format.html { render action: "new" }
        format.json { render json: @word_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /word_lists/1
  # PUT /word_lists/1.json
  def update
    logger.debug "UPDATING params: " + params.inspect

    @word_list = WordList.find(params[:id])

    logger.debug "update word list params: " + params.to_s

    p = self.add_word_order(params)

    logger.debug "update word list p: " + p.to_s

    respond_to do |format|
      if @word_list.update_attributes(p[:word_list])
        format.html { redirect_to edit_word_list_path(:id => @word_list.id), notice: 'Word list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @word_list.errors, status: :unprocessable_entity }
      end
    end
  end

#  # DELETE /word_lists/1
#  # DELETE /word_lists/1.json
#  def destroy
#    @word_list = WordList.find(params[:id])
#    @word_list.destroy
#
#    respond_to do |format|
#      format.html { redirect_to word_lists_url }
#      format.json { head :no_content }
#    end
#  end

  def add_word_order(p)
    logger.debug "add_word_order: " + p.inspect
    return p unless p["word_list"]["list_items_attributes"]
    p["word_list"]["list_items_attributes"].values.inject(0) do |i, word|
#      puts i.class
#      puts word.class
      logger.debug i.to_s + " " + word.inspect
      word["word_order"] = i.to_s
      i + 1
    end
    p
  end

	def maintain_assignments
		logger.debug "*************** maintain_assignments: " + params.inspect
		render :text => 'Internal error: missing word_list_id', :status => 500 and return unless params[:id]
		# TODO: Figure out why when I use this, I have to deal with params[:id] being a string...
		word_list_id = params[:id].to_i
		@word_list = WordList.find(word_list_id)
		@assigned = current_user.children_assigned_to(word_list_id)
		@unassigned = current_user.children_unassigned_to(word_list_id)
	end

	def assign_many
		logger.debug "*************** assign_many: " + params.inspect
		render :text => 'Internal error: missing parameters', :status => 500 and
			return unless params[:id] &&
				params[:user_ids]
		word_list = WordList.find(params[:id])
		params[:user_ids].each do |uid|
			word_list.assignments.create(:assigned_to_id => uid, :assigned_by_id => current_user.id)
		end
		redirect_to maintain_assignments_word_list_path(params[:id])

		#~ render :nothing => true
		#~ render :nothing => true and return if word_list.assignments.create(params[:assignment])
		#~ flash[:error] = 'Internal error: Failed to create assignment.'
		#~ redirect_to :back
	end

	def unassign_many
		logger.debug "*************** unassign_many: " + params.inspect
		render :text => 'Internal error: missing parameters', :status => 500 and
			return unless params[:id] &&
				params[:assignment_ids]
		word_list_id = params[:id].to_i
		params[:assignment_ids].each do |a|
			Assignment.find(a).destroy
		end
		redirect_to maintain_assignments_word_list_path(params[:id])

		#~ render :nothing => true
		#~ render :nothing => true and return if a.destroy
		#~ flash[:error] = 'Internal error: Failed to destroy assignment.'
		#~ redirect_to :back
	end

	def list_complete
		render :text => 'Internal error: missing parameters', :status => 500 and return unless params[:id]
		@word_list = WordList.find(params[:id])
		@url_for_ogg_file = File.join root_path, '119032__joedeshon__polite-applause-12.ogg'
		@url_for_mp3_file = File.join root_path, '119032__joedeshon__polite-applause-12.mp3'
	end

end
