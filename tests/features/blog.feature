Feature: Blog
  In order to promote the technical knowhow of our department
  As a technical lead
  I want to blog about our latest technical achievements

@api
Scenario: Blog post overview pager
  Given I have 15 blog posts
  When I visit the blog overview
  Then I should see 10 blog posts
  And I should see the next page link
  And I should not see the previous page link
  When I click the next page link
  Then I should see 5 blog posts
  And I should see the previous page link
  And I should not see the next page link
