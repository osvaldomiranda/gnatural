namespace :python do
  desc "Install python"
  task :install do
    run "#{sudo} apt-get -y install python-software-properties"
  end
end
