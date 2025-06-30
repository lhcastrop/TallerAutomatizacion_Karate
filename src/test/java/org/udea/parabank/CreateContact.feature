@appcontact_createcontact
Feature: create contact to app contact

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Login, crear contacto y validar existencia
    # Login
    Given path '/users/login'
    And request { "email": "pruebasleo@hotmail.com", "password": "12345678" }
    When method POST
    Then status 200
    * def authToken = response.token

    # Crear contacto
    * def uniqueEmail = 'user' + java.util.UUID.randomUUID() + '@hotmail.com'
    Given path '/contacts'
    And header Authorization = 'Bearer ' + authToken
    And request { "firstName": "Claret", "lastName": "Sepulveda", "birthdate": "1970-01-01", "email": uniqueEmail, "phone": "8005555555", "street1": "1 Main St.", "street2": "Apartment A", "city": "Anytown", "stateProvince": "KS", "postalCode": "12345", "country": "USA" }
    When method POST
    Then status 201

    # Validar que el contacto aparece en la lista
    Given path '/contacts'
    And header Authorization = 'Bearer ' + authToken
    When method GET
    Then status 200
    And match response[*].email contains uniqueEmail

  Scenario: Crear contacto con campos faltantes
    Given path '/users/login'
    And request { "email": "pruebasleo@hotmail.com", "password": "12345678" }
    When method POST
    Then status 200
    * def authToken = response.token

    Given path '/contacts'
    And header Authorization = 'Bearer ' + authToken
    And request { "lastName": "SinNombre" }
    When method POST
    Then status 400
