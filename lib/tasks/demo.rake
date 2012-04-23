#require Rails.root + 'app/helpers/demo_helper'

desc "Build the demo environment for teachers, April, 2012"
namespace :demo do
  task :demo_april_2012 => [ :environment, :unload_demo_april_2012 ] do
    include DemoHelper
    DemoHelper.load_demo_apr_2012
  end 
  task :unload_demo_april_2012 => [ :environment ] do
    include DemoHelper
    DemoHelper.unload_demo_apr_2012
  end 
end

