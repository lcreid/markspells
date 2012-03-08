class ListItemController < ApplicationController
  require File.join(File.dirname(__FILE__), '../helpers/e_speak_ror.rb')
  include UserHelper

  before_filter :current_user_id

  def practice
    #~ So of course each call to this is a new instance of the class.
    #~ That's what the web is all about.
    #~ I wasn't thinking RESTfully.
#    @list_item = ListItem.first(:order => "word_order") unless params[:id]
    @list_item = ListItem.find(params[:id]) # if params[:id]
    
    logger.debug "************ Practice: Current user ID: " + current_user_id.to_s

    @list_stats = ListStatsHelper::ListStats.new(current_user_id, @list_item.word_list_id)

    respond_to do |format|
      format.html  # practice.html.erb
      format.json  { render :json => @list_item }
    end
  end

  def test
  end

  def check
    logger.debug "********** Check: Current user id = " + current_user_id.to_s

    student_response = StudentResponse.new do |r|
      r.user_id = current_user_id
      r.word_id = params[:word_id]
      r.word = params[:word]
      r.student_response = params[:student_response]
    end

    respond_to do |format|
      if student_response.save then
      	logger.debug "******** Saved: " + student_response.inspect
        format.html {
          if student_response.correct then
#            flash[:message] = '<img src="/assets/checkmark-red.png" /><p>Well done!</p>'
            flash[:message] = view_context.image_tag("checkmark-red.png") + 'Well done!'
            list_item = ListItem.find(student_response.word_id)
            redirect_to(practice_list_item_path(:id => list_item.next_word_not_yet_answered_correctly(current_user_id)))
          else
            flash[:message] = "Sorry. Try again."
            redirect_to(practice_list_item_path(:id => student_response.word_id))
          end
        }
        format.json  { render :json => student_response, :status => :created, :location => student_response }
      else
        # TODO: Fix the following as it fails if the save fails.
        format.html { redirect_to(:practice, :notice => 'Student response creation failed.') }
        format.json  { render :json => student_response.errors, :status => :unprocessable_entity }
      end
    end
  end
end
