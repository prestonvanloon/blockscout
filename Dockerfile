FROM elixir:alpine as elixir-build-env
WORKDIR /src
RUN apk update && \
   apk add git automake autoconf libtool alpine-sdk && \
   rm -rf /var/cache/apk/*
ADD . /src
RUN mix local.hex --force
ENV MIX_ENV=prod
RUN mix do deps.get, local.rebar --force, deps.compile, compile

FROM node:alpine as node-build-env
WORKDIR /src
COPY --from=elixir-build-env /src /src
RUN cd apps/block_scout_web/assets && \
   npm install && \
   npm run deploy && \
   npm prune --production && \
   cd -
RUN cd apps/explorer && \
   npm install --production && \
   cd -

FROM elixir-build-env 
WORKDIR /src
COPY --from=node-build-env /src /src
RUN mix phx.digest

ENV MIX_ENV=prod 
ENV PORT=4000

EXPOSE 4000

CMD mix phx.server
