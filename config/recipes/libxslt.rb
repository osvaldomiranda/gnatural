namespace :libxslt do
  desc "Install libxslt (C library for GNOME)"
  task :install do
    run "#{sudo} apt-get -y install libxslt-dev libxml2-dev"
  end
end
