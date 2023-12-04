# README

This is a stock trading API backend running on docker container. In this application user can create
business with available shares as owner. Buyer users can see business with available shares, their purchase history
and request for buy share. On the other hand owner can see the share requests, accept or reject share request of
a particular business. As this application runs on docker, it is assumed that users have docker and 
docker compose installed in their local.

System Dependency:

* Ruby version - 3.2.2

* Rails version - 7.0.8

Configuration:

* make sure you give appropriate permission in project directory - like 'sudo chown -R $USER:$USER .
  '
* Run 'docker-compose build'

* Run 'docker-compose up'

* To access rails console, Run 'docker exec -it stock_trading_backend-stock-trading-rails-1 bash'

* Database initialization - database is created when docker is built, for test database create run
cmd 'bundle exec rails db:create'

* Make sure to run 'bundle exec rails db:seed' to get the user. It will create user for you.
  As this is protected API application, application will misbehave without this.

* To run the testing files - first access to the rails console mentioned earlier and run cmd
'bundle exec rspec'

* Documentation: https://documenter.getpostman.com/view/13503617/2s9YeLXUp7



