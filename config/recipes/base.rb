# Helpers
def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    update_packages
    
    libxslt.install
    python.install
    git.install
    
    nginx.install
    postgresql.install
    nodejs.install
    make.install
    redis.install
    rbenv.install
    ruby_dev.install
  end

  desc "Update ubuntu packages"
  task :update_packages do
    run "#{sudo} apt-get -y -f install"
    run "#{sudo} apt-get clean"
    run "#{sudo} apt-get -y --fix-missing update; true"
  end
end
