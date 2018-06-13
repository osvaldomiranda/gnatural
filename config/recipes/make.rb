namespace :make do
  desc "Install make"
  task :install do
    run "#{sudo} apt-get -y install make"
  end
end
