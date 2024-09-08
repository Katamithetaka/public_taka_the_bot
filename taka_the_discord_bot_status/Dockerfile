FROM debian:buster
WORKDIR /taka_the_discord_bot_status
COPY --from=taka_the_discord_bot_dependencies /app/build/taka_the_discord_bot_status .
RUN  apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
RUN update-ca-certificates
CMD ["/taka_the_discord_bot_status/taka_the_discord_bot_status"]