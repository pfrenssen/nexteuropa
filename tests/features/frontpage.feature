Feature: Frontpage
  In order to have an overview of the website
  As an anonymous user
  I want to see relevant information on the frontpage

Scenario: Anonymous user can see the frontpage
  Given I am not logged in
  When I visit "/"
  Then I should see the text "No front page content has been created yet."
  And I should not see the text "Log out"
