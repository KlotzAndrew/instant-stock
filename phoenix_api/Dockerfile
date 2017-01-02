FROM elixir:1.3.4

run mix local.hex --force

RUN mkdir /app
WORKDIR /app

COPY mix.exs /app/mix.exs
COPY mix.lock /app/mix.lock
RUN mix deps.get

COPY . /app

EXPOSE 4000
# CMD ["sh", "lib/scripts/start_webapp_production.sh"]
