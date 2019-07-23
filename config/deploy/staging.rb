set :branch, 'feature/static-sites'
set :rails_env, "production"
set :stage, :production
server 'trkit.club', user: 'deploy', roles: %w{app db web}