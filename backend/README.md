# Back-end

## Getting Started

### Prerequisites

This application was developed and tested using:

* Ruby 2.6.5
* PostgreSQL 9.6.17

The installation steps for above dependencies are not included in this document but there are a lot of good resources on Internet about how to do it for your specific operating system.

### Installing

Installing project's dependencies it's as easy as invoking `bundle`.

```
$ bundle install --path vendor/bundle
```

### Setting up environment variables

This application depends on few environment variables. You can set them in an `.env` file.

* `SALES_LOFT_API_KEY`: key for SalesLoft API (https://developers.salesloft.com/api.html#!/Topic/apikey)
* `DATABASE_URL`: your database URL (i.e. postgres://localhost/salesloft_dev)

You can also define specific variables per environment using `.env.production`, `.env.development`, and `.env.test` files. The environment variables defined in the `.env` file still have precedence and they will override the other ones.

### Setting up the database

Before running the next command, make sure you have the `DATABASE_URL` environment variable already in place (see above section).

```
$ bundle exec rake db:migrate
```

Then, you can pre-populate the database as shown below:

```
$ bundle exec rake people:import people:count_email_characters people:detect_duplicates
```

### Starting the server

To run the application server:

```
$ bundle exec rackup
```

## Running the tests

To run the whole testing suite:

```
$ bundle exec rake test
```

To run a single test case:

```
$ bundle exec rspec spec/core
```
