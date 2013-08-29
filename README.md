# Wordpress Vista
Wordpress Vista is a Rails application that stores all your hosted/local Wordpress website information from multiple servers and presents them in clear views. It is the server which saves all data collected from the [WP Vista Collector](https://github.com/tolgap/wp-vista-collector).

To collect the Wordpress data, you **NEED** the Collector running on your servers.

## Requirements

* [WP Vista Collector](https://github.com/tolgap/wp-vista-collector)
* Ruby >= 1.9

## Installation
First you checkout the project

    git clone git@github.com:tolgap/wp-vista.git
    cd wp-vista/

Install the bundles

    bundle install

Create the database by running the migrations

    bundle exec rake db:migrate

And once your [WP Vista Collectors](https://github.com/tolgap/wp-vista-collector) start pushing all the information, you will see it on your master server pages.

## Searching
For searching, WP Vista uses Sunspot Solr search. The `Gemfile` has been setup to install a Sunspot instance *with* Solr included, if you don't have it yet.

To get Sunspot running

    bundle exec rake sunspot:solr:run #foreground

Or to run it in the background

    bundle exec rake sunspot:solr:start #background

## Running the server
If you don't have Passenger running, you can always use WEBrick to start the server using

    cd wp-vista/
    rails s

Or if you do have Passenger, your Apache vhost should look like this:

    <VirtualHost *:80>
        ServerName wp-vista.domain
        DocumentRoot /path/to/wp-vista/public
        <Directory /path/to/wp-vista/public>
            Allow from all
            Options -MultiViews
        </Directory>
    </VirtualHost>