Tests for NextEuropa
====================

This folder contains tests for the NextEuropa profile. To run the tests:

First you need to install the dependencies using Composer:
```
$ cd tests
$ composer install
```

Then define the base URL to use in the tests (replacing "http://localhost"):
```
$ export BEHAT_PARAMS='{"extensions":{"Behat\\MinkExtension":{"base_url":"http://localhost"}}}'
```

Finally run the tests:
```
$ ./bin/behat
```

