# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, 'screenshot_taker'
set :repo_url, 'git@github.com:w00lf/screenshot_taker.git'
set :deploy_to, '/home/screenshot_taker/screenshot_taker'
set :chruby_ruby, 'ruby-2.5.5'
set :nginx_use_ssl, false
set :puma_init_active_record, true
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_files, fetch(:linked_files, []).push('config/settings/production.yml', 'config/settings/production.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')
set :keep_releases, 5