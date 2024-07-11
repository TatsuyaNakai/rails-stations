build:
	docker-compose build

up:
	docker-compose up -d
	docker attach rails-stations-web-1

stop:
	docker-compose stop

down:
	docker-compose down

bundle:
	docker-compose run --rm web bundle exec bundle install

console:
	docker-compose run --rm web bundle exec rails c

reinstall:
	docker-compose run --rm web bundle exec rails db:reinstall

rubocop:
	docker-compose run --rm web bundle exec rubocop $(path)

lint:
	docker-compose run --rm web bundle exec erblint --lint-all

erd:
	docker-compose run --rm web bundle exec rails mermaid_erd

annotate:
	docker-compose run --rm web bundle exec annotate

routes:
	docker-compose run --rm web bundle exec rails routes

rspec:
	docker-compose run --rm web bundle exec rspec $(path)

bash:
	docker-compose run --rm web bash

credentials:
	docker-compose run --rm -e EDITOR=vim web bin/rails credentials:edit --environment $(env)

cron:
	docker-compose run --rm web bundle exec whenever --update-crontab
