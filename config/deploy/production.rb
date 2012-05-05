#set :branch, 'production' # For when I have different branches in git

set :user, "ubuntu"

role :web, "ec2-204-236-210-66.compute-1.amazonaws.com"                   # Your HTTP server, Apache/etc
role :app, "ec2-204-236-210-66.compute-1.amazonaws.com"                   # This may be the same as your `Web` server
role :db,  "ec2-204-236-210-66.compute-1.amazonaws.com", :primary => true # This is where Rails migrations will run
role :db,  "ec2-204-236-210-66.compute-1.amazonaws.com"

