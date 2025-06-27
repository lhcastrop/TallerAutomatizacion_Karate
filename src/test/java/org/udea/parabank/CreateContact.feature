@appcontact_CreateContact
Feature: Create contact to app contact

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Customer Login
    Given path '/users/login'
    And request {"email": "pruebaleo@hotmail.com","password": "12345678"}
    When method POST
    * def authToken = response.token
    
   Scenario: Customer Create contact
     Given path '/contacts'
     And header Authorization = 'Bearer' + authToken
     And request {
    "firstName": "John",
    "lastName": "Doe",
    "birthdate": "1970-01-01",
    "email": "jdoe@fake.com",
    "phone": "8005555555",
    "street1": "1 Main St.",
    "street2": "Apartment A",
    "city": "Anytown",
    "stateProvince": "KS",
    "postalCode": "12345",
    "country": "USA"}
    When method POST 
    Then status 201
