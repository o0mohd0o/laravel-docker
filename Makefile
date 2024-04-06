setup:
	@make build
	@make up
	@make composer-update
build:
	docker-compose build --no-cache --force-rm
stop:
	docker-compose stop
up:
	docker-compose up -d
composer-update:
	docker exec laravel-app bash -c "composer update"
data:
	docker exec laravel-app bash -c "php artisan migrate"
	docker exec laravel-app bash -c "php artisan db:seed"
migrate:
	docker exec laravel-app php artisan migrate
seed:
	docker exec laravel-app php artisan db:seed
bash:
	docker exec -it laravel-app bash

args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`
cli:
	echo docker exec laravel-app php artisan $(call args)
%:
	@:
composer:
	docker exec laravel-app composer $(call args)
make/migrate:
	docker exec laravel-app php artisan make:migration $(call args)
make/seed:
	docker exec laravel-app php artisan make:seed $(call args)



