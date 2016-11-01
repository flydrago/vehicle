# config valid only for current version of Capistrano
#lock '3.5.0'

set :application, 'elephant'
set :deploy_user, 'deploy'
set :repo_url, 'ssh://git@www.nit.cn:7999/jyd/elephant.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
#set :branch, 'develop'

# Default deploy_to directory is /var/www/my_app_name

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
#set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/mongoid.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/upload','public/assets')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# set :resque_server_roles, :web

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.3.1'


after "deploy:published", "god:resque_restart"
after "deploy:restart", "god:resque_restart"

namespace :god do
  desc "god restart resque and resque-scheduler"
  task :resque_restart do
    on roles(:web) do
      with path: '/home/deploy/.rbenv/shims:$PATH' do
        within(current_path) do
          execute :god, "stop resque_elephant"
          execute :god, "load #{current_path}/config/resque-pool.god"
          execute :god, "start resque_elephant"
        end
      end
    end
  end
end

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end




