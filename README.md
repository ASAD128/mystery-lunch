# Mystery Lunch 
A Ruby on Rails-based full stack web application that facilitates random lunch pairings between employees from different departments

## Features
1. Mystery Lunch web application randomly selects employees from different departments every month to have lunch together. 
  - Application makes sure that each selected lunch partner belong to different department
  - Application also makes sure that selected partners haven't had coffee together in last 3 months

2. Admin can add or delete employees to the system
  - When admin adds a new employee it will be added to exiting lunch partners pair (3 people lunch)
  - When admin removes an employee it will be removed from future lunch and remaining partner would join an existing pair

3. User can apply filters based on date & departments 
4. A rake task runs every month to generate random mystery lunch partners

## Demo
https://github.com/ASAD128/mystery-lunch/assets/22412472/19255b32-ef5b-4681-9bce-315514eee1e8



## Models
- *User*:
  Devise gem model for admin authentication
- *Employee*:
   To store employees data
- *Department*:
   To store department data
- *MysteryPartners*:
   Store randomly selected mystery partners e.g employees and their departments


## Ruby
ruby 2.7.7

## Rails
Rails 6.1.7

## Docker
`docker-compose up --build`

## Database
Postgresql 
`rake db:create`
`rake db:migrate`
`rake db:seed`

## Rake Task to Generate MysteryPartners
`rake mystery_partner_generator_task`
Note: this rake task would be automatically schedule once every month using whenever gem & Sidekiq

## Sidekiq
Sidekiq schedule job `MysteryLunchPartnerGeneratorWorker` 

## Rspec 
`Rspec` & `FactoryBot` used to write the specs

## Admin
Admin can create/delete employees and departments. 
Admin apart of the app is authenticated via devise gem

## Algorithm
How algorithm works?
1. Store employees in hash based on their departments
2. Find available partner against each employee while removing partners which are from different department 
   or already had lunch with that employee in last 3 months 
3. For odd number of employee, remaining partner is added existing lunch and pair
4. In the end data is persisted into the DB

Time complexity O(n) <= O(e x d) where e is number of employee and d is the number of department
   




