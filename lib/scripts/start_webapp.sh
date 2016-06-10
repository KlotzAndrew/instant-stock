#! /bin/sh

cd "$(dirname "$0")"
cd ../..
echo $PWD
rm -f tmp/pids/server.pid
bundle exec rails s -b '0.0.0.0'

