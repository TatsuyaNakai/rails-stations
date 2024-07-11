# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Rails.rootの使用
require File.expand_path("#{File.dirname(__FILE__)}/environment")

# 環境変数のセット
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
ENV.each { |k, v| env(k, v) }

set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: '7:00 pm' do
  rake 'user:remind_reservations'
end

every 1.day, at: '12:00 am' do
  runner "Ranking.insert_daily_rankings!"
end

# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# Learn more about test: https://github.com/rafaelsales/whenever-test
