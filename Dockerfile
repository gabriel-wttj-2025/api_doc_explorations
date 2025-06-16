FROM elixir:1.14.5

# Install build tools and inotify-tools
RUN apt-get update && \
    apt-get install -y build-essential inotify-tools

WORKDIR /app
COPY . /app

RUN mix local.hex --force && \
    mix local.rebar --force

CMD mix deps.get && \
    mix ecto.create && \
    mix ecto.migrate && \
    mix phx.server