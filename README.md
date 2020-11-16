# Welcome

Hello GlossGenious Team, in this repository you will find my solution to your coding challange. 


## Installation
Before you start with installation make sure are using rspec gemset or similar to avoid conflicts
with your local setup.

As this is standard Ruby on Rails app, you can start with:

```
bundle && rake db:create:all
```

## Populate database

If you want to use my test data seed the database 

`rake db:seed`

## Testing 

To run test suite

`bundle exec rspec .`

## Postman

To test API vith standard server requests:

`bundle exec rails s`

To test proper response use the following curl comands:

* list all users
  `curl localhost:3000/api/v1/users`

* user details
  `curl localhost:3000/api/v1/users/1`

* create test campaign
  `curl -d "@test/data/campaign.json" -H "Content-Type: application/json" -X POST localhost:3000/api/v1/campaigns`




