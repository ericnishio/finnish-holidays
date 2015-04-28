finnish-holidays
================

[![Build Status](https://travis-ci.org/ericnishio/finnish-holidays.svg?branch=master)](https://travis-ci.org/ericnishio/finnish-holidays)

A CLI and utility library for listing Finnish national holidays.

## Installation

    $ gem install finnish-holidays

## CLI Usage

    $ finnish-holidays

List of commands:

    $ finnish-holidays --help

## In Code

```ruby
require 'finnish-holidays'

FinnishHolidays.next()
FinnishHolidays.year(2016)
FinnishHolidays.month(1, 2017)
```

## Run Tests

    $ rspec
