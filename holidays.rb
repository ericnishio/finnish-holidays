#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'json'

class Year
  @year = nil
  @page = nil
  @holidays = nil

  def initialize year
    if year.is_a? Integer and year > 0
      @year = year.to_s
      @holidays = Hash.new { |hash, key| hash[key] = [] }
      @page = Nokogiri::HTML(open('http://www.webcal.fi/fi-FI/pyhat.php?y=' + @year))
      self.parse_holidays()
    else
      raise "Invalid year: #{year}"
    end
  end

  def parse_holidays
    @page.css('table.basic tr').each do |el|
      if el.css('th:last-child').text != 'Päivämäärä' # TODO: Improve check.
        date_el = el.css('td:nth-child(4)')
        description_el = el.css('td:nth-child(2)')

        month = self.get_month(date_el.text)
        day = self.get_day(date_el.text)
        description = description_el.text

        if !defined? @holidays[month]
          @holidays[month] = Array.new
        end

        holiday = {
          day: day,
          description: description
        }

        @holidays[month].push(holiday)
      end
    end
  end

  def get_holidays
    return @holidays
  end

  def get_json
    return self.get_holidays.to_json
  end

  def get_day date_string
    parts = date_string.split('.')
    return parts[0].to_i
  end

  def get_month date_string
     parts = date_string.split('.')
     return parts[1].to_i
  end
end

class Holidays
  @year = nil
  @month = nil
  @day = nil

  def initialize
    @year = Time.now.year
    @month = Time.now.month
    @day = Time.now.day
  end

  def this_month
    year = Year.new(@year)
    return year.get_holidays[@month]
  end

  def next
    year = Year.new(@year)
    holidays = Array.new

    if defined? year.get_holidays[@month]
      year.get_holidays[@month].each do |holiday|
        if (holiday[:day] > @day)
          puts holidays.push(holiday)
        end
      end
    end

    return holidays
  end
end
