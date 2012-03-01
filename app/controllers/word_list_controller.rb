class WordListController < ApplicationController
  # GET /word_lists
  # GET /word_lists.json
  def index
    @word_lists = WordList.all
    
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
#  def new
#    @word_list = WordList.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @word_list }
#    end
#  end
#
#  # GET /word_lists/1/edit
#  def edit
#    @word_list = WordList.find(params[:id])
#  end
#
#  # POST /word_lists
#  # POST /word_lists.json
#  def create
#    @word_list = WordList.new(params[:word_list])
#
#    respond_to do |format|
#      if @word_list.save
#        format.html { redirect_to @word_list, notice: 'Word list was successfully created.' }
#        format.json { render json: @word_list, status: :created, location: @word_list }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @word_list.errors, status: :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /word_lists/1
#  # PUT /word_lists/1.json
#  def update
#    @word_list = WordList.find(params[:id])
#
#    respond_to do |format|
#      if @word_list.update_attributes(params[:word_list])
#        format.html { redirect_to @word_list, notice: 'Word list was successfully updated.' }
#        format.json { head :no_content }
#      else
#        format.html { render action: "edit" }
#        format.json { render json: @word_list.errors, status: :unprocessable_entity }
#      end
#    end
#  end
#
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
