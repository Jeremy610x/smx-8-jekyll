#!/bin/bash

export JEKYLL_VERSION=3.8.6

update() {

    docker run --rm \
        --env JEKYLL_UID=$UID \
        --env JEKYLL_GID=$UID \
        --volume="$PWD:/srv/jekyll" \
        --volume="$PWD/_site:/srv/jekyll/_site" \
        --volume="$PWD/_bundle:/usr/local/bundle" \
        jekyll/jekyll:$JEKYLL_VERSION \
        bundle update
}

run() {
   
    docker run --rm \
        --env JEKYLL_UID=$UID \
        --env JEKYLL_GID=$UID \
        --volume="$PWD:/srv/jekyll" \
        --volume="$PWD/_site:/srv/jekyll/_site" \
        --volume="$PWD/_bundle:/usr/local/bundle" \
        --publish 4000:4000 \
        --publish 35729:35729 \
        jekyll/jekyll:$JEKYLL_VERSION \
        jekyll serve --livereload --incremental
}

case $1 in
    update)
        update;;
    run)
        run
    ;;
    *)
        echo "Usage: $0 run | update"
    ;;
esac