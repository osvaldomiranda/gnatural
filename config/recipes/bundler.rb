namespace :bundler do
  desc "Install bundler"
  task :install do
    run "#{sudo} apt-get -y install bundler"
  end
end