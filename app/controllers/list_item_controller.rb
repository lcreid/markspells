class ListItemController < ApplicationController
  def practice
  		#~ So of course each call to this is a new instance of the class.
		#~ That's what the web is all about.
		#~ Not thinking RESTfully. 
		@list_item = ListItem.first(:order => "word_order") unless params[:id]
		@list_item = ListItem.find(params[:id]) if params[:id]
		
   respond_to do |format|
			format.html  # practice.html.erb
			format.json  { render :json => @list_item }
		end
end

  def test
  end

  def check
		student_response = StudentResponse.new do |r|
			r.word_id = params[:word_id]
			r.word = params[:word]
			r.student_response = params[:student_response]
		end
		#~ student_response.check

    respond_to do |format|
      if student_response.save then
        format.html { 
					if student_response.correct then
						flash[:notice] = "Well done!"
						redirect_to(practice_list_item_path(:id => ListItem.find(student_response.word_id).next))
					else
						flash[:notice] = "Sorry. Try again."
						redirect_to(practice_list_item_path(:id => student_response.word_id)) 
					end
					}
        format.json  { render :json => student_response, :status => :created, :location => student_response }
      else
        format.html { redirect_to(:practice, :notice => 'Student response creation failed.') }
        format.json  { render :json => student_response.errors, :status => :unprocessable_entity }
      end
    end
  end
end
