class WordListsController < ApplicationController
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
		redirect_to(practice_list_item_path(@word_list.list_items.first.id))
	end

  def cuadrant
    # We expect a :criteria hash to tell us what to report on
    render :text => 'Internal error: missing id', :status => 500 and return unless params[:id]
    @green_list = StudentResponse.green_list(:word_list_id => params[:id])
    @orange_list = StudentResponse.orange_list(:word_list_id => params[:id])
    @yellow_list = StudentResponse.yellow_list(:word_list_id => params[:id])
    @red_list = StudentResponse.red_list(:word_list_id => params[:id])
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
    @word_list = WordList.new(params[:word_list])
    
    logger.debug "CREATING: " + @word_list.inspect
    @word_list.list_items.each { |w| logger.debug "\t" + w.inspect }
    logger.debug "VALIDATE: " + @word_list.valid?.to_s

    respond_to do |format|
      if @word_list.save
        format.html { redirect_to word_lists_path, notice: 'Word list was successfully created.' }
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
    @word_list = WordList.find(params[:id])
    
    logger.debug "update word list params: " + params.to_s

    respond_to do |format|
      if @word_list.update_attributes(params[:word_list])
        format.html { redirect_to word_lists_path, notice: 'Word list was successfully updated.' }
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
end
