#! /bin/sh

cd /myapp
bundle exec sidekiq -C confif/sidekiq.yml -e production
