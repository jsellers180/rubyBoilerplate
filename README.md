SVOD-Website-Tests
==========================

This suite uses Cucumber, Ruby & Capybara to test the SVOD website in a headless fashion.

Software used
-------------
```sh
Cucumber is a software tool used for testing other software.
```

```ruby
Ruby is an open-source programming language.
```

```ruby
Capybara is a test framework that helps you test web apps by simulating how a real user would interact with the app.
```

```
Phantomjs is a headless WebKit scriptable with a JavaScript API
```

To run the feature files on OSX
-------------------------------

Step 1 - Install homebrew & rbenv

Open a new Terminal and run the following commands:
```ruby
Install Homebrew
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Install rbenv
$ brew install rbenv
```
Open a new terminal tab (command + t) and verify rbenv is installed
```ruby
$ rbenv
```

Step 2 - Clone the spiritclips-tests repository
```
$ git clone https://github.com/spiritclips/spiritclips-tests.git
```

Step 3 - cd (change directory) into the cloned repo and install Ruby
```ruby
$ cd /spiritclips-tests
$ rbenv install (This will automatically install the ruby version the tests are using)
$ rbenv global 2.3.1
$ rbenv rehash
```
Step 4 - Install the required gems. Execute:
```ruby
$ gem install bundler 
$ bundle install
```

Step 5 - Install phantomjs 
```ruby
$ brew install phantomjs
```

From here you can now start executing the tests!

Features
========

To run individual features
--------------------------
```ruby
$ bundle exec cucumber features/"feature_name.feature" target="domain"
```

Example:
--------
```ruby
$ bundle exec cucumber features/login.feature target=staging
```

Tags
====

To run individual or multiple tags
---------------------------------------
```ruby
$ bundle exec cucumber --tags @tag_name target="domain"
```


Available tags
--------------
```
@smoketest - Runs a basic smoketest against the targeted environment. 
@header-footer - Runs a set of tests that verify links in the header and footer.
@login - Runs the login feature. 
@signup - Runs the signup feature
@negative - Runs the tagged negative tests
@account - Runs the account feature
@regression - Runs a larger suite of tests than smoketest
@prod - Runs the prod feature. This is the only set that can be run vs prod. 
@watchlist - Runs tests to verify the watchlist functionality
@wip - These tests are in progress and will not run by default
```

Available Targets
-----------------
```
target=
dev | staging | prod | qa
```

Example:
--------
```ruby
$ bundle exec cucumber --tags @smoketest target=staging
```
Reporting
=========

Running the suite with reporting
---------------------------------------
The following command will run the smoketest tag against the default environment. 
It will use the 'report' profile defined in cucumber.yml
The report will be available in features/results
```ruby
$ bundle exec cucumber --tags @smoketest -p report
```

Running PROD/ADMIN tests
========================

NOTE: An admin level user is required to run tests with the @admin tag.
The following is a prerequisite to running tests vs the @prod tag or @admin tag
```ruby
$ export PROD_LOGIN='your_email_here@hallmarklabs.com'
$ export PROD_PASS='your_password_here'
```
Once you have exported your information, run the following command
```ruby
$ printenv
```
Verify that your login and password are listed in the environment and you can now run the prod environment tests. 
