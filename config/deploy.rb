# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'DishColor'
set :repo_url, 'git@github.com:Fool-Stack-Rangers/DishColor.git'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'
set :deploy_to, '/home/deploy/sites/DishColor'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}
set :linked_files, %w{config/database.yml config/application.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end


 set :rollbar_token, ENV['ROLLBAR_ACCESS_TOKEN']
 set :rollbar_env, Proc.new { fetch :stage }
 set :rollbar_role, Proc.new { :app }


#  task :notify_rollbar do
#    on roles(:app) do |h|
#        revision = `git log -n 1 --pretty=format:"%H"`
#        local_user = `whoami`
#        execute "curl https://api.rollbar.com/api/1/deploy/ -F access_token=#{rollbar_token} -F environment=#{rails_env} -F revision=#{revision} -F local_username=#{local_user} >/dev/null 2>&1", :once => true
#      end
#  end
#  after :deploy, 'notify_rollbar'

  # task :notify, :roles => [:web] do
  #   set :revision, `git log -n 1 --pretty=format:"%H"`
  #   set :local_user, `whoami`
  #   set :rollbar_token, ENV['ROLLBAR_ACCESS_TOKEN']
  #   #set :rollbar_env, Proc.new { fetch :stage }
  #   #set :rollbar_role, Proc.new { :app }
  #   rails_env = fetch(:rails_env, 'production')
  #   run "curl https://api.rollbar.com/api/1/deploy/ -F access_token=#{rollbar_token} -F environment=#{rails_env} -F revision=#{revision} -F local_username=#{local_user} >/dev/null 2>&1", :once => true
  # end
  # after :deploy, 'notify'


  after :publishing, :restart
  after :finishing, 'deploy:cleanup'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

#after "deploy:restart", "rollbar:notify"

# namespace :rollbar do
#   task :notify, :roles => [:web] do
#     set :revision, `git log -n 1 --pretty=format:"%H"`
#     set :local_user, `whoami`
#     set :rollbar_token, ENV['ROLLBAR_ACCESS_TOKEN']
#     #set :rollbar_env, Proc.new { fetch :stage }
#     #set :rollbar_role, Proc.new { :app }
#     rails_env = fetch(:rails_env, 'production')
#     run "curl https://api.rollbar.com/api/1/deploy/ -F access_token=#{rollbar_token} -F environment=#{rails_env} -F revision=#{revision} -F local_username=#{local_user} >/dev/null 2>&1", :once => true
#   end
# end


