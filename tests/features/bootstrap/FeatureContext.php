<?php

/**
 * @file
 * Contains \FeatureContext.
 */

use Drupal\DrupalExtension\Context\RawDrupalContext;
use Behat\Behat\Context\SnippetAcceptingContext;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawDrupalContext implements SnippetAcceptingContext {

  /**
   * Initializes context.
   *
   * Every scenario gets its own context instance.
   * You can also pass arbitrary arguments to the
   * context constructor through behat.yml.
   */
  public function __construct() {
  }

  /**
   * @Then I should see the next page link
   */
  public function assertNextPageLinkExists() {
    $this->assertSession()->elementExists('css', 'li.pager__item--next');
  }

  /**
   * @Then I should not see the next page link
   */
  public function assertNextPageLinkNotExists() {
    $this->assertSession()->elementNotExists('css', 'li.pager__item--next');
  }

  /**
   * @Then I should see the previous page link
   */
  public function assertPreviousPageLinkExists() {
    $this->assertSession()->elementExists('css', 'li.pager__item--previous');
  }

  /**
   * @Then I should not see the previous page link
   */
  public function assertPreviousPageLinkNotExists() {
    $this->assertSession()->elementNotExists('css', 'li.pager__item--previous');
  }

  /**
   * @When I click the next page link
   */
  public function clickNextPageLink() {
    $this->getSession()->getPage()->clickLink('Go to next page');
  }
}
