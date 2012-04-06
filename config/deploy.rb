require "bundler/capistrano"
 
 set :application, "markspells"
set :repository,  "git@github.com:lcreid/markspells.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm_username, "lcreid"

set :deploy_to, "/var/www"

role :web, "passenger"                          # Your HTTP server, Apache/etc
role :app, "passenger"                          # This may be the same as your `Web` server
role :db,  "passenger", :primary => true # This is where Rails migrations will run
role :db,  "passenger"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end

