set :ip, "198.58.124.176"
server "#{ip}", :web, :app, :db, primary: true
set :rails_env, 'production'