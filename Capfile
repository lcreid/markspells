load 'deploy'
# Uncomment if you are using Rails' asset pipeline
    # load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks
load 'deploy/assets'

require 'capistrano/ext/multistage'

default_run_options[:pty] = true 
set :keep_releases, 4
ssh_options[:forward_agent] = true

# In the end, none of this shit works in the start-up case.
namespace :db do
  task :db_config, :except => { :no_release => true }, :role => :app do
    parent_path = File.dirname release_path
    previous = capture("ls -t1 #{parent_path} | head -2 | tail -1")
    previous = File.join(parent_path, previous.rstrip, "config", "database.yml")
    # I think this ruby code is running on the client machine, 
    # therefore you can't check for file existence using ruby
    run "if [ -e #{previous} ] ; then cp -f #{previous} #{release_path}/config ; else cp -f ~/database.yml #{release_path}/config ; fi"
  end
end

after "deploy:finalize_update", "db:db_config"
