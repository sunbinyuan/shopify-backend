# README

Shopify backend challenge

## Getting started

### Prerequisites
You must have an installation of `ruby >= 2.2.2` 

### Installing

1. Change directory to the root of the application:

		$ cd shopify-backend

2. Install `bundler` at the command prompt if you haven't yet:

		$ gem install bundler

3. Install all the dependencies :

		$ bundle install

4. Migrate the database:
		
		$ rails db:migrate

## Running the server

1. At the root of the application, start the server:

		$ rails server

2. Goto `http://localhost:3000` and you should see the server running with the default rails landing page

3. Follow the API documentation in order to test the different features of the application

## Documentation

Visit the [API documentation created with Apiary](https://app.apiary.io/binyuanshopifybackendchallenge)

## Other thoughts/Improvements

* A User system could be implemented with Cart belonging to user

* Render of JSON can be made more consistent across the Item and Cart controllers

* ~~Access token system can be implemented in order to prevent unauthorized Item modification~~

* An Order model could be implemented in order to store purchased Items

* A job could be added to purged unused Carts after a interval of time

* Unit tests

## Authors

* **Binyuan Sun** 