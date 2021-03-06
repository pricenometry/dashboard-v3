require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/chruby'
# require 'mina_sidekiq/tasks'
require 'mina/unicorn'

set :user, 'ubuntu'
set :domain, ENV['DOMAIN']
set :deploy_to, '/home/ubuntu/dashboard-v3'
set :app_path, lambda { "#{deploy_to}/#{current_path}" }
set :repository, 'https://github.com/pricenometry/dashboard-v3.git'
set :branch, 'master'
set :forward_agent, true
set :rails_env, 'production'
set :keep_releases, 5
# set :sidekiq_log, "#{deploy_to}/#{shared_path}/log/sidekiq.log"
# set :sidekiq_pid, "#{deploy_to}/#{shared_path}/tmp/pids/sidekiq.pid"

set :shared_paths, ['public/static',
                    'config/database.yml',
                    'config/config.yml',
                    'config/secrets.yml',
                    # 'db/production.sqlite3',
                    # 'app/sites',
                    'tmp/sockets',
                    'tmp/pids',
                    'log']

task :environment do
  invoke :'chruby[ruby-2.3.0]'
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/public"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/public/static"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  # queue! %[mkdir -p "#{deploy_to}/#{shared_path}/db"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/app/sites"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/config.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]
  # queue! %[touch "#{deploy_to}/#{shared_path}/db/production.sqlite3"]

  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/public"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/public/static"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]
  # queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/db"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids"]
  # queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/app/sites"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end

  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    # invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      # queue "touch #{deploy_to}/#{shared_path}/pids/sidekiq.pid"
      # invoke :'sidekiq:restart'
      # queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      invoke :'unicorn:restart'
      # queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers
