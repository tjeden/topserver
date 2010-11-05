Feature: Send Tasks

  In order to have working server
  As a server
  I want to send task

  Scenario: Sending task
    Given a server exists 
    And a client exists
    And a task exists
    And a client is registered in server with that task
    When server notice there is a task, which can be done by client
    Then server should send task to client
