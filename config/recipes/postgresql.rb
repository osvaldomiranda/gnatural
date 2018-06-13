set_default(:postgresql_host, "localhost")
set_default(:postgresql_user) { application }
set_default(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL user #{postgresql_user} password: " }
set_default(:postgresql_database) { "#{application}_#{rails_env}" }

namespace :postgresql do
  desc "Install the latest stable release of PostgreSQL."
  task :install, roles: :db, only: {primary: true} do
    run "#{sudo} add-apt-repository ppa:pitti/postgresql" do |ch, stream, data|
      if data =~ /Press.\[ENTER\].to.continue/
        ch.send_data("\n")
      else
        # Use the default handler for all other text
        Capistrano::Configuration.default_io_proc.call(ch,stream,data)
      end
    end
    run "#{sudo} apt-get -y install postgresql-common"
    run "#{sudo} apt-get -y install postgresql-9.3 libpq-dev"
  end

  desc "Create a database for this application."
  task :create_database, roles: :db, only: {primary: true} do
    # Change Default Encoding of New Databases To UTF-8
    run %Q{#{sudo} -u postgres psql -c "UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';"}
    run %Q{#{sudo} -u postgres psql -c "DROP DATABASE template1;"}
    run %Q{#{sudo} -u postgres psql -c "CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';"}
    run %Q{#{sudo} -u postgres psql -c "UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';"}
    # Create the user
    run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
    # Create database
    run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} with owner=#{postgresql_user} encoding='utf-8';"}
    run %Q{#{sudo} -u postgres psql -c "grant all privileges on database #{postgresql_database} to #{postgresql_user};"}
    run %Q{#{sudo} -u postgres psql -c "alter role #{postgresql_user} LOGIN;"}
    # Close the template
    run %Q{#{sudo} -u postgres psql -c "\\c template1;"}
    run %Q{#{sudo} -u postgres psql -c "VACUUM FREEZE;"}
    run %Q{#{sudo} -u postgres psql -c "UPDATE pg_database SET datallowconn = FALSE WHERE datname = 'template1';"}
  end
  after "deploy:setup", "postgresql:create_database"

  desc "Generate the database.yml configuration file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
  end

  desc "Drops database and user."
  task :destroy, roles: :db, only: {primary: true} do
    run %Q{#{sudo} -u postgres psql -c "drop database #{postgresql_database};"}
    run %Q{#{sudo} -u postgres psql -c "drop role #{postgresql_user};"}
  end
  after "deploy:setup", "postgresql:setup"

  desc "Symlink the database.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "postgresql:symlink"
end
