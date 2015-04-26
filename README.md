finnish-holidays
================

A tool for displaying Finnish national holidays.

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
