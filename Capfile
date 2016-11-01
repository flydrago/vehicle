# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require 'capistrano/rvm'
require 'capistrano/rbenv'
# require 'capistrano/chruby'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'
# require 'capistrano/passenger'
require 'capistrano/puma'
#require 'capistrano/puma/workers'

require 'capistrano/console'
require 'capistrano-resque-pool'
require 'capistrano-resque'
require 'capistrano/sudo'
require 'capistrano/logrotate'
# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }


# namespace :god do
#
#   desc "god restart resque and resque-scheduler"
#   task :resque_restart do
#     on roles(:web) do
#       execute "cd /alidata1/www/elephant/current"
#       execute "god stop resque_elephant"
#       execute "god load config/resque-pool.god"
#       execute "god start resque_elephant"
#     end
#   end
#
#   desc "god start resque and resque-scheduler"
#   task :resque_start do
#     on roles(:web) do
#       execute "cd /alidata1/www/elephant/current && god load config/resque-pool.god && god start resque_elephant"
#     end
#   end
#
#   desc "god stop resque and resque-scheduler"
#   task :resque_stop do
#     on roles(:web) do
#       execute "cd /alidata1/www/elephant/current && god stop resque_elephant"
#     end
#   end
#
# end