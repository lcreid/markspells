class ListItemController < ApplicationController
  require File.join(File.dirname(__FILE__), '../helpers/e_speak_ror.rb')
  include OldUserHelper

  before_filter :old_current_user_id

  def practice
    #~ So of course each call to this is a new instance of the class.
    #~ That's what the web is all about.
    #~ I wasn't thinking RESTfully.
#    @list_item = ListItem.first(:order => "word_order") unless params[:id]
    @list_item = ListItem.find(params[:id]) # if params[:id]
    
    logger.debug "************ Practice: Current user ID: " + old_current_user_id.to_s

    @list_stats = old_current_user.current_practice_session
    
    respond_to do |format|
      format.html  # practice.html.erb
      format.json  { render :json => @list_item }
    end
  end

  def test
  end

  def check
    # TODO: This would be more natural in a StudentResponses controller.
    logger.debug "********** Check: " + params.to_s
    
    student_response = old_current_user.current_practice_session.student_responses.create(
      :word_id => params[:word_id],
      :word => params[:word],
      :student_response => params[:student_response],
      :start_time => params[:start_time],
      :end_time => Time.now.utc.to_s)

    respond_to do |format|
      if student_response.save then
        format.html {
          if student_response.correct then
            flash[:message] = '<div id="feedback"><div id="graphic">' + 
              view_context.image_tag("checkmark-green-121x106.png", :class => "v-centre-img") + 
              '</div><div id="message" class="h-centre v-centre">Correct! Well done!</div></div>'
            list_item = ListItem.find(student_response.word_id)
            redirect_to(practice_list_item_path(:id => old_current_user.current_practice_session.next_word_not_yet_answered_correctly(list_item)))
          else
            flash[:message] = '<div id="feedback"><div id="message" class="h-centre v-centre">Sorry. Try again.</div></div>'
            redirect_to(practice_list_item_path(:id => student_response.word_id))
          end
        }
        format.json  { render :json => student_response, :status => :created, :location => student_response }
      else
        format.html { redirect_to(practice_list_item_path(student_response.word_list.id), :notice => 'Student response creation failed.') }
        format.json  { render :json => student_response.errors, :status => :unprocessable_entity }
      end
    end
  end
end
