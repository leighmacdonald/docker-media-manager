# Docker Media Manager

## Usage

Create your config files based on the examples provided:

	cp env_example env
	$EDITOR env
	cp config_example.yml config.yml
	$EDITOR config.yml

Authenticate trakt connection

	docker-compose run flexget trakt auth <your_trakt_username>

Set a flexget WebUI password (if you want to use it)

 	docker-compose run flexget web passwd <new_password>`

