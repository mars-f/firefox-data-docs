# This container provides a Gitbook author's toolkit.
#
# Files are served from "/book" inside the container.
#
# To build the image:
#
# $ docker build -t gitbook .
#
# To run a development shell:
#
# $ docker run --rm --mount type=bind,source=$(pwd),target=/book -p 4000:4000 -it gitbook sh
#
# Once you have a development shell running, available commands are:
#
#   Run the gitbook live-reload server.  Output is viewable on the docker host
#   at http://localhost:4000:
#
#     /book # gitbook serve
#
#   Run the spell checker:
#
#     /book # scripts/spell_check.sh
#

FROM node:9-alpine

RUN set -ex; \
    mkdir -p /book; \
    npm install -g gitbook-cli; \
    npm install -g markdown-spellcheck

# Ensure the project plugins are installed in the base image
WORKDIR /
COPY book.json .
RUN gitbook install

EXPOSE 4000

WORKDIR /book

CMD ["sh"]