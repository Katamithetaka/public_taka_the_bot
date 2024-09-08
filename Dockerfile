# Using the `rust-musl-builder` as base image, instead of 
# the official Rust toolchain
FROM clux/muslrust:stable
USER root
WORKDIR /app

COPY target/x86_64-unknown-linux-musl/release/taka_the_discord_bot ./build/taka_the_discord_bot_client
COPY target/x86_64-unknown-linux-musl/release/taka_the_discord_bot_api ./build/taka_the_discord_bot_api   
COPY target/x86_64-unknown-linux-musl/release/taka_the_discord_bot_status ./build/taka_the_discord_bot_status    
COPY target/x86_64-unknown-linux-musl/release/tetrio_html_server ./build/taka_the_discord_bot_tetrio_html_server

COPY ./taka_the_discord_bot_client/.env.prod ./taka_the_discord_bot_client/.env.prod
COPY ./taka_the_discord_bot_api/.env.prod ./taka_the_discord_bot_api/.env.prod
# COPY ./taka_the_discord_bot_status/.env ./build/taka_the_discord_bot_status/
COPY ./taka_the_discord_bot_tetrio_html_server/.env ./taka_the_discord_bot_tetrio_html_server/.env
