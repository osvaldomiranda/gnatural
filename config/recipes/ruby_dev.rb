namespace :ruby_dev do
  desc "Install ruby-dev"
  task :install do
    run "#{sudo} apt-get -y install ruby-dev"
  end
end