# Welcome

Hello GlossGenious Team, in this repository you will find my solution to your coding challange. 


## Installation
Before you start with installation make sure are using rspec gemset or similar to avoid conflicts
with your local setup.

As this is standard Ruby on Rails app, you can start with:

```
bundle && rake db:create:all && rake db:migrate
```

## Populate database

If you want to use my test data seed the database 

`rake db:seed`

## Automated Tests

To run test suite

`bundle exec rspec .`


## Setting up mail clients

### Sendgrid 
  
Simply set `SENDGRID_API_KEY` in the `.env` file.

### Mailgun

Set `MAILGUN_API_KEY` and `MAILGUN_DOMAIN` in the `.env` file.
In sandbox enviornment add test user emails as [Authorized Recipients](https://help.mailgun.com/hc/en-us/articles/217531258)

## API tests

To test API vith standard server requests:

`bundle exec rails s`

To test proper response use the following curl comands:

* create new user
`curl -d '{"data":{"attributes":{ "email":"test@example.com"}}}'  -H "Content-Type: application/json" -X POST localhost:3000/api/v1/users`

* list all users
  `curl localhost:3000/api/v1/users`

* user details
  `curl localhost:3000/api/v1/users/1`

* create test campaign from predefined data
  `curl -d "@test/data/campaign.json" -H "Content-Type: application/json" -X POST localhost:3000/api/v1/campaigns`

* create test campaign from dynamic data
  `curl -d '{"data": { "attributes": { "message": "Test", "subject": "Hi", "recipients": ["test@example.com"] }}}' -H "Content-Type: application/json" -X POST localhost:3000/api/v1/campaigns`







