set :user, "reid"

role :web, "passenger"                          # Your HTTP server, Apache/etc
role :app, "passenger"                          # This may be the same as your `Web` server
role :db,  "passenger", :primary => true # This is where Rails migrations will run
role :db,  "passenger"

