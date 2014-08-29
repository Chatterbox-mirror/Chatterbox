#!/usr/bin/env puma

directory '/home/gitcafe/chatterbox/current'
rackup "/home/gitcafe/chatterbox/current/config.ru"
environment 'production'

pidfile "/home/gitcafe/chatterbox/shared/tmp/pids/puma.pid"
state_path "/home/gitcafe/chatterbox/shared/tmp/pids/puma.state"
stdout_redirect '/home/gitcafe/chatterbox/shared/log/puma_access.log', '/home/gitcafe/chatterbox/shared/log/puma_error.log', true


threads 0,16

bind 'unix:/home/gitcafe/chatterbox/shared/tmp/sockets/puma.sock'
workers 0



preload_app!


on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/home/gitcafe/chatterbox/current/Gemfile"
end


