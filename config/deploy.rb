require "bundler/capistrano"
require 'capistrano/ext/multistage'
 
# Load recipes
load "config/recipes/base"
load "config/recipes/git"
load "config/recipes/make"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql" 
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"
load "config/recipes/solr"
load "config/recipes/redis"
load "config/recipes/bundler"
load "config/recipes/sidekiq"
load "config/recipes/ruby_dev"
load "config/recipes/python"
load "config/recipes/libxslt"

set :stages, %w(production staging)
set :default_stage, "production"

# Application info
set :user, "deployer"
set :application, "hikerdata"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :use_sudo, false
set :rails_env, 'stagind'


# Repository info
set :scm, "git"
set :git_user, 'osvaldomiranda'
set :repository, "git@github.com:#{git_user}/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# Keep only the last 5 releases
after "deploy", "deploy:cleanup" 


before 'deploy:finalize_update', 'deploy:assets:symlink'
after 'deploy:update_code', 'deploy:assets:precompile'

namespace :deploy do
  namespace :assets do

    task :precompile, :roles => :web do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ lib/assets/ app/assets/ | wc -l").to_i > 0
        run_locally("rake assets:clean && RAILS_ENV=production bundle exec rake assets:precompile")
        run_locally "cd public && tar -jcf assets.tar.bz2 assets"
        top.upload "public/assets.tar.bz2", "#{shared_path}", :via => :scp
        run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
        run_locally "rm public/assets.tar.bz2"
        run_locally("rake assets:clean")
      else
        logger.info "Skipping asset precompilation because there were no asset changes"
      end
    end

    task :symlink, roles: :web do
      run ("rm -rf #{latest_release}/public/assets &&
            mkdir -p #{latest_release}/public &&
            mkdir -p #{shared_path}/assets &&
            ln -s #{shared_path}/assets #{latest_release}/public/assets")
    end
  end
end


