# Development for Flask Toolbox

## Development environment

* Ruby 2.2.4
* Rails 4.2.6

## Install the dependencies and set up the database

Clone the repo and install the dependencies:

    $ git clone https://github.com/lord63/flask_toolbox_by_rails.git
    $ cd flask_toolbox_by_rails
    $ bundle install

Initialize the database:

    $ bin/rake db:setup

## Fetch the package info

We use resque as our Active Job's queueing backend. Make sure redis is running,
then run all queues by:

    $ QUEUE=* rake environment resque:work

Then, run the rake task to fetch the package info:

    $ bin/rake update:pypi
    $ bin/rake update:github

You have a very basic app now, run the server by:

    $ bin/rails server

Check our basic app at http://127.0.0.1:3000, there is also a simple admin interface
at http://127.0.0.1:3000/admin
