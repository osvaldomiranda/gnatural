namespace :sidekiq do
  desc "Start sidekiq"
  task :start, roles: :app do
  	#run "cd #{current_path} && nohup bundle exec sidekiq -e #{rails_env} -C config/sidekiq.yml -P tmp/pids/sidekiq.pid >> log/sidekiq.log < /dev/null 2>&1 & sleep 1"
  	#run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec sidekiq"
  	run "cd #{current_path} && nohup bundle exec sidekiq -e #{rails_env} -P tmp/pids/sidekiq.pid >> #{current_path}/log/sidekiq.log < /dev/null 2>&1 & sleep 1"
  end
end