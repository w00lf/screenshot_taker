set :branch, ENV.fetch('DEPLOY_BRANCH', 'master')
server 'screenshot_taker', user: 'screenshot_taker', roles: %w{app db web}