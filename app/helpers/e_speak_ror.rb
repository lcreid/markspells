# Use ESpeak in Ruby on Rails
# Inspired and code copied from FestivalttsOnRails by
# Sergio Espeja (sergio.espeja@gmail.com) (sergioespeja.com)

require "digest/md5"
require "#{File.dirname(__FILE__)}/e_speak.rb"

MP3_FLASH_PLAYER_URL = "/flash/dewplayer.swf"
MP3_FOLDER_URL = "/e_speak_tmp"
MP3_FOLDER_PATH = File.join("#{Rails.root}/public", MP3_FOLDER_URL)

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
