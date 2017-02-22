# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'stock'
set :repo_url, 'github.com'
set :deploy_to, '/var/www/stock'
set :deploy_user, :deploy

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
# Default value for :pty is false
# set :pty, true

set :scm, :git
set :format, :pretty
set :log_level, :debug

set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :rvm_type, :user
set :rvm_ruby_version, '2.2.3'
set :rvm_roles, [:app, :web, :db]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :restart do
    invoke 'unicorn:restart'
  end

end
