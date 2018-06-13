namespace :imagemagick do
  desc "Install imagemagick"
  task :install, roles: :web do
    run "#{sudo} apt-get -y install imagemagick libmagickcore-dev"
    run "#{sudo} apt-get -y install libmagickwand-dev"
  end
end