# Wordpress Vista
Wordpress Vista is a Rails application that stores all your hosted/local Wordpress website information from multiple servers and presents them in clear views. It is the server which saves all data collected from the [WP Vista Collector](https://github.com/tolgap/wp-vista-collector).

To collect the Wordpress data, you **NEED** the Collector running on your servers.

## Requirements

* [WP Vista Collector](https://github.com/tolgap/wp-vista-collector)
* Ruby >= 1.9

## Installation
First you checkout the project

    # On your server with all the Wordpress directories
    git clone git@github.com:tolgap/wp-vista.git
    cd wp-vista/

Install the bundles

    bundle install

Create the database by running the migrations

    bundle exec rake db:migrate

And once your [WP Vista Collectors](https://github.com/tolgap/wp-vista-collector) start pushing all the information, you will see it on your server.
