<?php

/**
 * @file
 * Contains \Drupal\nexteuropa\Context\NextEuropaDrupalContext.
 */

namespace Drupal\nexteuropa\Context;

use Drupal\DrupalExtension\Context\DrupalContext;

/**
 * Provides step definitions for interacting with the NextEuropa platform.
 */
class NextEuropaDrupalContext extends DrupalContext {

  /**
   * {@inheritdoc}
   */
  public function loggedIn() {
    $session = $this->getSession();
    $session->visit($this->locatePath('/'));

    // Check if the 'user-logged-in' class is present on the page.
    $element = $session->getPage();
    return $element->find('css', 'body.user-logged-in');
  }

}
