class ListItemsController < ApplicationController
  require File.join(File.dirname(__FILE__), '../helpers/e_speak_ror.rb')
  include OldUserHelper

  before_filter :authenticate_user!

  def practice_with_letters
    practice_setup params
    @with_letters = "_with_letters"
    @letters_on_off_string = "Hide number of letters"
    @letters_on_off_path = practice_list_item_path(params[:id])
  end

  def practice
    practice_setup params
    @with_letters = ""
    @letters_on_off_string = "Show number of letters"
    @letters_on_off_path = practice_with_letters_list_item_path(params[:id])

    respond_to do |format|
      format.html  # practice.html.erb
      format.json  { render :json => @list_item }
    end
  end

  def test
  end

  def check_with_letters
    logger.debug "********** Check With Letters: " + params.to_s
    @with_letters = "_with_letters"
    student_response = params[:student_response].reduce(:+)
    check_body(ListItem.find(params[:word_id]), student_response, params[:start_time], params[:end_time], "practice_with_letters")
  end

  def check
    # TODO: This would be more natural in a StudentResponses controller.
    logger.debug "********** Check: " + params.to_s
    @with_letters = ""
    check_body(ListItem.find(params[:word_id]), params[:student_response], params[:start_time], params[:end_time], "practice")

  end

  private
  def check_body(word, students_word, start_time, end_time, next_action)
    student_response = current_user.current_practice_session.student_responses.create(
      :word_id => word.id,
      :word => word.word,
      :student_response => students_word,
      :start_time => start_time,
      :end_time => end_time)

    respond_to do |format|
      if student_response.save then
        format.html {
          if student_response.correct then
				 if current_user.current_practice_session.complete? then
					 redirect_to list_complete_word_list_path(word.word_list)
				else
					flash[:message] = '<div id="feedback"><div id="graphic">' +
					  view_context.image_tag("checkmark-green-121x106.png", :class => "v-centre-img") +
					  '</div><div id="message" class="h-centre v-centre">Correct! Well done!</div></div>'
					redirect_to(:action => next_action,
					    :controller => controller_name,
					    :id => current_user.current_practice_session.next_word_not_yet_answered_correctly(word))
				end

          else
            flash[:message] = '<div id="feedback"><div id="message" class="h-centre v-centre">Sorry. Try again.</div></div>'
            redirect_to(:action => next_action, :controller => controller_name, :id => word.id)
          end
        }
        format.json  { render :json => student_response, :status => :created, :location => student_response }
      else
        format.html { redirect_to(practice_list_item_path(word), :notice => 'Student response creation failed.') }
        format.json  { render :json => student_response.errors, :status => :unprocessable_entity }
      end
    end
  end

  def practice_setup(params)
  # TODO: Rails 3 has helpers for the <audio> tag that I should investigate. Puts stuff in public/audios.
    @list_item = ListItem.find(params[:id]) # if params[:id]
    # logger.debug "************ Practice: Current user ID: " + current_user.id.to_s
    @list_stats = current_user.current_practice_session
    @url_for_mp3_file = text_to_mp3(@list_item.verbal_prompt, :speed => 100, :gap => 3, :voice => "english-mb-en1", :volume => 150)
    @url_for_ogg_file = text_to_ogg(@list_item.verbal_prompt, :speed => 100, :gap => 3, :voice => "english-mb-en1", :volume => 150)
  end
end
