namespace :git do
  desc "Install git"
  task :install do
    run "#{sudo} apt-get -y install git"
  end
end
