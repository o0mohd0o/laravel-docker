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
	docker exec madfu-app bash -c "composer update"
data:
	docker exec madfu-app bash -c "php artisan migrate"
	docker exec madfu-app bash -c "php artisan db:seed"
migrate:
	docker exec madfu-app php artisan migrate
seed:
	docker exec madfu-app php artisan db:seed
bash:
	docker exec -it madfu-app bash

args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`
cli:
	echo docker exec madfu-app php artisan $(call args)
%:
	@:
composer:
	docker exec madfu-app composer $(call args)
make/migrate:
	docker exec madfu-app php artisan make:migration $(call args)
make/seed:
	docker exec madfu-app php artisan make:seed $(call args)



