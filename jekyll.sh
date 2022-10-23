#!/bin/bash

export JEKYLL_VERSION=3.8.6

init() {

    touch Gemfile.lock
    chmod a+w Gemfile.lock

    #rm .jekyll-metadata
    touch .jekyll-metadata
    chmod a+w .jekyll-metadata

    docker volume create smx-8-jekyll
    docker volume create smx-8-jekyll-bundle

}

update() {
    
    init

    docker run --rm \
        --volume="$PWD:/srv/jekyll" \
        --volume="site:/srv/jekyll/_site" \
        --volume="bundle:/usr/local/bundle" \
        -it jekyll/jekyll:$JEKYLL_VERSION \
        bundle update
}

run() {
   
    init

    docker run --rm \
        --volume="$PWD:/srv/jekyll:Z" \
        --volume="site:/srv/jekyll/_site:Z" \
        --volume="bundle:/usr/local/bundle:Z" \
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