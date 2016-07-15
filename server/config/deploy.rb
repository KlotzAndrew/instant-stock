# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'instantstock_web'
set :repo_url, 'https://github.com/KlotzAndrew/instant-stock'
set :docker_repo, 'klotzandrew/instantstock_web'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

desc 'Build Docker images'
task :build do
  # do you app pre-deploy stuff here.

  # build the actual docker image, tagging the push for the remote repo
  system "docker build -t #{fetch(:docker_repo)} ."
  system "echo 'should be building an image...'"
end

desc 'Push Docker images'
task :push do
  system "docker push #{fetch(:docker_repo)}"
  system "echo 'should be pushing image to remote repo...'"
end

desc 'go'
task :go => ['build', 'push', 'deploy']

desc 'deploy'
task :deploy do
  on roles(:app) do
    system "echo 'should be pulling image from remote repo...'"
    # execute "docker pull #{fetch(:docker_repo)}"
    Rake::Task['deploy:restart'].invoke
  end
end

namespace :deploy do
  task :restart do
    on roles(:app) do
      # in case the app isn't running on the other end
      # execute "docker stop #{fetch(:application)} ; true"
      execute "docker-compose -f /var/www/instantstock_web/current/docker-compose-production.yml stop ; true"
      system "echo 'should be stopping container...'"

      # have to remove it otherwise --restart=always will run it again on reboot!
      system "echo 'maybe remove old containers?'"
      # execute "docker rm #{fetch(:docker_repo)} ; true"

      # modify this to suit how you want to run your app
      # execute "docker run -d -p 3000:3000 --restart=always --name=#{fetch(:application)} #{fetch(:local_repo)}"
      execute "docker-compose -f /var/www/instantstock_web/current/docker-compose-production.yml up -d ; true"
      system "echo 'start new containers...'"
      # execute "docker-compose up"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
