# set_default :ruby_version, "2.1.2"
# set_default :rbenv_bootstrap, "bootstrap-ubuntu-14-04"

namespace :rbenv do
  desc "Install rbenv, and the Bundler gem"
  task :install, roles: :app do
    install_rbenv
    set_rbenv_paths

    install_ruby_build    
    set_ruby_build_path
  end

  desc "Installs rbenv, by cloning the git repo"
  task :install_rbenv do
    run "cd"
    run "git clone git://github.com/sstephenson/rbenv.git .rbenv"
  end

  desc "Set rbenv paths"
  task :set_rbenv_paths, rols: :app do
    run "echo '# Paths for rbenv' >> ~/.bashrc"
    run "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> ~/.bashrc"
    run 'echo \'eval "$(rbenv init -)"\' >> ~/.bashrc'
    run ". ~/.bashrc"
  end

  desc "Installs ruby-build, by cloning the git repo (makes rbenv install command available)"
  task :install_ruby_build do
    run "git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"
  end

  desc "Set ruby-build paths"
  task :set_ruby_build_path do
    run 'echo \'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"\' >> ~/.bashrc'
    run ". ~/.bashrc"
  end
end
