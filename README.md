finnish-holidays
================

A tool for displaying Finnish national holidays.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'finnish-holidays'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install finnish-holidays

## CLI Usage

    $ finnish-holidays

Help:

    $ finnish-holidays --help

## In Code

```ruby
require 'finnish-holidays'

FinnishHolidays.holidays(10, false)
```
