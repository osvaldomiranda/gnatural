namespace :init do
  desc "Execute seeds.rb"
  task :seed, roles: :app do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake db:seed"
  end
end