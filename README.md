# README

 --- Ecommerce Cart Checkout App ---

* Ruby version
  ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin16]

* Database creation
  bundle exec rake db:create

* Database initialization
  bundle exec rake db:migrate db:seed

* How to run the test suite
  bundle exec rspec

* Features
  1. A basic restful json api and basic html <form></form>(MVC) to create, list, update, show and delete the products.
  2. An api to add items to the basket/cart.
  3. An api which returns list items from the basket/cart(with individual price and
  discount data),the total price and total discounts applied.
  4. Test case for the discount calculations logic(Services::Checkout).
