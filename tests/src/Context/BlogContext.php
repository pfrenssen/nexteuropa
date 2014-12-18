<?php

/**
 * @file
 * Contains \Drupal\nexteuropa\Context\BlogContext.
 */

namespace Drupal\nexteuropa\Context;

use Drupal\DrupalExtension\Context\RawDrupalContext;
use Drupal\node\Entity\Node;

/**
 * Provides step definitions for the Blog feature.
 */
class BlogContext extends RawDrupalContext {

  /**
   * Creates n blog posts with random title and content.
   *
   * @Given (I have ):number blog post(s)
   *
   * @param int $number
   *   The number of random blog posts to create.
   */
  public function createBlogPosts($number) {
    $number = (int) $number;
    if ($number < 1) {
      throw new \InvalidArgumentException('Invalid number.');
    }
    for ($i = 0 ; $i < $number ; $i++) {
      $blog_post = (object) array(
        'type' => 'blog',
        'title' => $this->getRandom()->string(),
        'body' => $this->getRandom()->string(),
        'status' => 1,
        // Use a random creation date in the past 7 days.
        'created' => date('Y-m-d h:i:s', rand(time()-7*24*60*60, time())),
      );
      $this->nodeCreate($blog_post);
    }
  }

  /**
   * @When (I )visit the blog overview
   * @When I am on the blog overview
   */
  public function iAmOnBlogOverview() {
    $this->visitPath('/blog');
  }

  /**
   * @Then I should see :number blog posts
   *
   * @param int $number
   *   The number of blog posts that should be seen.
   */
  public function assertBlogPostCount($number) {
    $this->assertSession()->elementsCount('css', 'article.node--type-blog', intval($number));
  }

}
