# Use ESpeak in Ruby on Rails
# Inspired and code copied from FestivalttsOnRails by
# Sergio Espeja (sergio.espeja@gmail.com) (sergioespeja.com)

require "digest/md5"
require "#{File.dirname(__FILE__)}/e_speak.rb"

MP3_FLASH_PLAYER_URL = "/flash/dewplayer.swf"
MP3_FOLDER_URL = "/e_speak_tmp"
MP3_FOLDER_PATH = File.join("#{Rails.root}/public", MP3_FOLDER_URL)

# NEW FUNCTIONS BY LARRY
# TODO: This is a great big race condition.
# Multiple students doing the same list are sure to cause each other grief.
# TODO: Once approach would be to use the parameters in the name, and
# not overwrite if the file exists.
def text_to_mp3(text, params = {})
  filename = Digest::MD5.hexdigest(text).to_s + ".mp3"

  # The place where the file is in the filesystem...
  filepath = File.join(MP3_FOLDER_PATH, filename)
  text.to_mp3(filepath, params)

  # ...is different from its URL which is what you play
  File.join(MP3_FOLDER_URL, filename)
end

def text_to_ogg(text, params = {})
  filename = Digest::MD5.hexdigest(text).to_s + ".ogg"

  # The place where the file is in the filesystem...
  filepath = File.join(MP3_FOLDER_PATH, filename)
  text.to_ogg(filepath, params)

  # ...is different from its URL which is what you play
  File.join(MP3_FOLDER_URL, filename)
end

# Generates the mp3 file and the javascript utility that shows the
# voice player.
# The options NOT CURRENTLY available are:
# - bgcolor: default = "FFFFFF"
# - width: default = 200
# - height: default = 20
def text_to_flash_player(text, params = {})
  #  bgcolor = params[:bgcolor] if opts[:bgcolor]
  #  width = params[:width] if opts[:width]
  #  height = params[:height] if opts[:height]

  filename = Digest::MD5.hexdigest(text).to_s + ".mp3"

  text.to_mp3(File.join(MP3_FOLDER_PATH, filename), params) # unless File.exists?(filename)
  html_for_mp3_flash(File.join(MP3_FOLDER_URL, filename))
end

# Returns needed html for playing mp3.
def html_for_mp3_flash(filename, bgcolor = "000000", width = 200, height = 20)
#  "<object type=\"application/x-shockwave-flash\" \
#  data=\"#{MP3_FLASH_PLAYER_URL}\" width=\"#{width}\" height=\"#{height}\" id=\"dewplayer\" name=\"dewplayer\">\n" +
#  "<param name=\"wmode\" value=\"transparent\" />\n" +
#  "<param name=\"movie\" value=\"dewplayer.swf\" />\n" +
#  "<param name=\"flashvars\" value=\"mp3=/home/reid/spelling/a.mp3&amp;autostart=1\" />\n" +
##  "<param name=\"flashvars\" value=\"mp3=#{filename}&amp;autostart=1\" />\n" +
#  "</object>"
	"<object type=\"application/x-shockwave-flash\" data=\"#{MP3_FLASH_PLAYER_URL}\" width=\"#{width}\" height=\"#{height}\" id=\"dewplayer\" name=\"dewplayer\">\n" +
	"<param name=\"wmode\" value=\"transparent\" /> \n" +
	"<param name=\"movie\" value=\"dewplayer.swf\" /> \n" +
	"<param name=\"flashvars\" value=\"mp3=#{filename}&amp;autostart=1\" /> \n" +
	"</object>\n"
end

module Espeak
  def Espeak.filename(text, params = {})
    filename = Digest::MD5.hexdigest(text + params.to_s).to_s
  end

  def Espeak.url_for_ogg_file(text, params = {})
    url_for_file(text, params) + ".ogg"
  end

  def Espeak.url_for_mp3_file(text, params = {})
    url_for_file(text, params) + ".mp3"
  end

  def Espeak.url_for_file(text, params = {})
    File.join(MP3_FOLDER_URL, filename(text, params))
  end

  def Espeak.path_for_file(text, params = {})
    File.join(MP3_FOLDER_PATH, filename(text, params))
  end

  def Espeak.generate_sound_files(text, params = {})
    text.to_ogg(path_for_file(text, params) + ".ogg", params)
    text.to_mp3(path_for_file(text, params) + ".mp3", params)
  end

end
