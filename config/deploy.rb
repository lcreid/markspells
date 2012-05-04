set :application, "markspells"
set :repository,  "git@github.com:lcreid/markspells.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm_username, "lcreid"

set :deploy_to, "/var/www"

set :stages, ["staging", "production"]
set :default_stage, "staging"
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "markspells.pem")]

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

set :rvm_type, :system  # Copy the exact line. I really mean :system here
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")

require "bundler/capistrano"
require "rvm/capistrano"
 
# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end

