set :ip, "192.168.1.191"
server "#{ip}", :web, :app, :db, primary: true
set :rails_env, 'production'

 # para conectarse a la BD desde el server
 # psql -h 192.168.1.130  -U marcelo -d ZDM  -W 