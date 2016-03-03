Feature: Home page

  Background:
    Given I navigate on [Home] page


  Scenario:  Sign up

    When I click on 'Register' tab
    And I fill sign up form with following data:
      | name | email                  | password  | confirm_password |
      | test | test098@mailinator.com | test12345 | test12345        |
    Then I should see 'test' user's
