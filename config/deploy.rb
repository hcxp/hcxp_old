require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'    # for rvm support. (http://rvm.io)
require 'mina/multistage'

set :forward_agent, true     # SSH forward_agent.

set :shared_paths, [
  '.env',
  'config/database.yml',
  'log',
  'public/uploads'
]

task :ssh => :environment do
  exec "ssh #{user}@#{domain}"
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/secrets.yml'."]

  queue! %[mkdir "#{deploy_to}/#{shared_path}/config/initializers/"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/initializers/env_variables.rb"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/initializers/env_variables.rb'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # queue 'rake db:schema:load RAILS_ENV=production'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue  %[echo "-----> Reloading nginx"]
      queue "mkdir -p #{deploy_to}/current/tmp/"
      queue "touch #{deploy_to}/current/tmp/restart.txt"
    end
  end
end
