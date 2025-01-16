Feature: My awesome feature

This feature describes usage of basic Gherkin syntax
For example, features can have descriptions
    
Scenario: go to control
    Given I am in the homepage
    When I tap 'Controls'
    Then I see 'Controls Screen'

Scenario: go to list
    Given I am in the homepage
    When I tap 'Alerts'
    Then I see 'Alerts'

Scenario: test Pippo
    Given I am in the homepage
    When I use Pippo.increment
    Then Pippo.count is 1
