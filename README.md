# Docker Media Manager

The docker compose file will setup the following application in their own containers:

- [Sonarr](https://sonarr.tv/) Download TV Shows
- [Radarr](https://radarr.video/) A fork of sonarr focused on Movies
- [Jackett](https://github.com/Jackett/Jackett) Adds the ability for radarr & sonarr to index & search torrent sites that dont provide a real API, most do not.
- [Bazarr](https://www.bazarr.media/) Download subtitles
- [Flexget](https://flexget.com/) Download trakt watchlist for TV shows and send them to Sonarr so they will be downloaded, Radarr has this ability built in for movies
- [Deluge](https://deluge-torrent.org/) For the actual downloading of torrents, other clients should be pretty trivial to substitute
- [HTPC-Manager](https://github.com/HTPC-Manager/HTPC-Manager) Simple frontend status of the services, very much optional

## Usage

The images assume you have 3 common bind mount directories setup that are shared between the containers, you need to change your mount points 
in `docker-compose.yml` to match your setup:

- /downloads
- /tv
- /movies

`env` Common env variables used when creating the containers. You should edit this to match your locale & uid/gids if required.

`config.yml` The flexget configuration file. Set your account name and api key.

Create your config files based on the examples provided:

	cp env_example env
	$EDITOR env
	cp config_example.yml config.yml
	$EDITOR config.yml

Authenticate trakt connection. Follow the instructions shown to authenticate the container to access the service.

	docker-compose run flexget trakt auth <your_trakt_username>

Set a flexget WebUI password (if you want to use it)

 	docker-compose run flexget web passwd <new_password>`

Start all the containers

	docker-compose up -d
	
The default urls will be as follows:

- http://<your_host_ip>:8989/ Sonarr
- http://<your_host_ip>:7878/ Radarr
- http://<your_host_ip>:9117/ Jackett
- http://<your_host_ip>:6767/ Bazarr 
- http://<your_host_ip>:8112/ Deluge
- http://<your_host_ip>:8085/ HTPC-Manager

You will still need to setup the actual applications as needed. When specifying hosts during the configuration steps, you should be using the docker internal network dns names as follow:

- http://deluge/
- http://sonarr/
- http://jackett/
- http://bazarr/
- http://deluge/

Do not use specific hardcoded IP's 
