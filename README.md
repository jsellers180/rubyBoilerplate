Website-Tests
=============

This suite uses Cucumber, Ruby & Capybara to test a website in a headless fashion.

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

Step 2 - Clone the repository

Step 3 - cd (change directory) into the cloned repo and install Ruby
```ruby
$ cd /
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
$ bundle exec cucumber
```

Example:
--------
```ruby
$ bundle exec cucumber
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
