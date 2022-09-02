<!-- # README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... -->
![Turing](https://global-uploads.webflow.com/6181549f60a2245732e2f91b/6193f9ff1e2ea00183765ef1_turing-logo-gray.png)
# **Rails-Engine**
Verson 1
### **About**
- This project is an API only rails app
- Several API endpoints created, allowing a user to reach specific endpoints with item, and merchant data.
- A TDD Driven Application
- Implementation of Serializers, and Factories to generate data for test suites.
- Developed around SRP, CRUD, and REST

### **Local Setup**
- Fork and clone repo
- Install gems: bundle install
- Create your database: rails db:create
- Ruby version: 2.7.4
- Rails version: 5.2.8

## **Endpoints Provided**
1. Get all merchants (merchants/index)
2. Get one merchant (merchants/show)
3. Get all items for a given merchant (merchant_items/index)
4. Get all items (items/index)
5. Get one item (items/show)
6. Create an item (items/create)
7. Update an item (items/update)
8. Delete an item (items/destroy)
9. Get merchant data for a given item (item_merchant/index)
10. Find one item through a search (items/find)
11. Find all merchants through a search (merchants/find_all)
