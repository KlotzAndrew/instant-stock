# Instant-Stock

Automated stock trading app with a chat room

### Setup

It is all docker containers, so just run: `docker-compose up`
Web container needs `mix ecto.setup` on first
run

Client runs at `/` api server runs on `:4000`

### Goals

Automated stock trading app, with some 'twitch plays pokemon' community
chat behaviour. Mostly an app to play around on and learn

### Architecture

All the services run in docker containers:

![Architecture diagram](architecture.png)

Client
 * Node/express JS app, React/Redux/ImmutableJS
 * Nginx load balancer for node app

Server
 * Phoenix app, json api/websockets
 * Nginx load balancer for phoenix app

Persistence
 * PG db

### TODO

 * <s>Replace rails api with phoenix app</s>
 * Add GraphQL endpoint
 * Add logging service (Graylog?)
 * Setup PG master/slave (PgBouncer?)
 * Upgrade stock quote API to something more reliable
 * Serve react app from s3
 * Paginate main page items
 * Switch to docker swarm
