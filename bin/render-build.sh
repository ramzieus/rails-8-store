# !/usr/bin/env bash
# exit on error
set -o errexit
rm ../config/credentials.yml.enc
bundle exec rails credentials:edit
bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

bundle exec rails db:setup