# Vista
Vista is a Rails application that stores all your hosted/local Wordpress and Drupal website information from multiple servers and presents them in clear views. It is the server which saves all data collected from the [Vista Collector](https://github.com/tolgap/vista-collector).

To collect the Wordpress and Drupal website data, you **NEED** the Collectors running on your servers.

## Requirements

* [Vista Collector](https://github.com/tolgap/vista-collector)
* Ruby >= 1.9.3

## Installation
First you checkout the project

    git clone git@github.com:tolgap/vista.git
    cd vista/

Install the bundles

    bundle install

Create the database by running the migrations

    bundle exec rake db:migrate

And once your [Vista Collectors](https://github.com/tolgap/vista-collector) start pushing all the information, you will see it on your master server pages.

## Running the server
If you don't have Passenger running, you can always use WEBrick to start the server using

    cd vista/
    [bundle exec] rails s

Or if you do have Passenger, your Apache vhost should look like this:

    <VirtualHost *:80>
        ServerName vista.domain
        DocumentRoot /path/to/vista/public
        <Directory /path/to/vista/public>
            Allow from all
            Options -MultiViews
        </Directory>
    </VirtualHost>