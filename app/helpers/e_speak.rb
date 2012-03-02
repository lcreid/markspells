class String
  def to_speaker(params = {})
    to_speech params # the defaults are good for this for now
  end

  def to_mp3(output_file, params = {})
  	params[:output_file] = output_file
  	to_speech params
  end

  def to_speech(params = {})
  	text = params[:text] || self
  	output_file = params[:output_file] || ""
  	
    # -z suppresses the pause at the end of the last sentence, but that cuts things off
    # too quickly if there is no punctuation.
    # This will fail if there are any "s in the text.
  	command = "espeak#{" --stdout" unless output_file.empty? }"
  	command += " -v " + params[:voice] if params[:voice]
  	command += " -a " + params[:volume].to_s if params[:volume]
  	command += " -g " + params[:gap].to_s if params[:gap]
  	command += " -s " + params[:speed].to_s if params[:speed]
  	command += " \"#{text.to_s}\" 2>/dev/null"
  	command += " | lame --alt-preset cbr 16 " +
  						"-a --resample 11 --lowpass 5 -X3 - " +
  						">#{output_file} 2> /dev/null" unless output_file.empty?
		
    system(command)
  end
end
