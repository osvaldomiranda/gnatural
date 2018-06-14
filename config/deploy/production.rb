set :ip, "192.168.1.191"
server "#{ip}", :web, :app, :db, primary: true
set :rails_env, 'production'