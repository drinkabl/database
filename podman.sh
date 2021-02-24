podman run -d \
   --restart always \
   --name timescale \
   --network slirp4netns:port_handler=slirp4netns \
   -p 5432:5432 \
   -e POSTGRES_USER='drinkable' \
   -e POSTGRES_PASSWORD='kmmHBxxfxm9xTNKMdtvbnCBFp8CceESC' \
   -v ./database/script/:/docker-entrypoint-initdb.d/:z \
   -v ./data/database/:/var/lib/postgresql/data/:z \
   docker.io/timescale/timescaledb-postgis:latest-pg12

podman run -d \
   --restart always \
   --name adminer \
   --network slirp4netns:port_handler=slirp4netns \
   -p 5001:8080 \
   docker.io/library/adminer

