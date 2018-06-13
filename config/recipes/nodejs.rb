namespace :nodejs do
  desc "Install the latest relase of Node.js"
  task :install, roles: :app do
    run "#{sudo} add-apt-repository ppa:chris-lea/node.js" do |ch, stream, data|
      if data =~ /Press.\[ENTER\].to.continue/
        ch.send_data("\n")
      else
        # Use the default handler for all other text
        Capistrano::Configuration.default_io_proc.call(ch,stream,data)
      end
    end
    run "#{sudo} apt-get -y install nodejs"
  end
end
