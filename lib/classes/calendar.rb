require 'time'
require_relative 'year'
require_relative '../utils/date-utils'

module FinnishHolidays
  class Calendar
    MAX_HOLIDAYS = 100

    def initialize(y = nil, m = nil, d = nil)
      @y = y == nil ? Time.now.year : y
      @m = m == nil ? Time.now.month : m
      @d = d == nil ? Time.now.day : d

      @year = FinnishHolidays::Year.new(@y)
    end

    def next(count = 3, include_weekends = false)
      if count > MAX_HOLIDAYS
        raise "Cannot request more than #{MAX_HOLIDAYS} holidays at once."
      end

      holidays = []

      while holidays.length < count
        if !include_weekends
          @year.discard_weekends()
        end

        if (defined? @year.holidays[@m]) && (@year.holidays[@m].is_a? Array)
          @year.holidays[@m].each do |holiday|
            if (holidays.length < count) && (holiday['day'] >= @d)
              holidays.push(holiday)
            end
          end
        end

        if holidays.length < count
          next_month()
        end
      end

      holidays
    end

    def year(year, weekends = false)
      if !weekends
        @year.discard_weekends()
      end

      holidays = []

      @year.holidays.each do |month, array|
        array.each do |holiday|
          holidays.push(holiday)
        end
      end

      holidays
    end

    def month(month, year, weekends = false)
      if !weekends
        @year.discard_weekends()
      end

      holidays = []

      if @year.holidays[month].is_a? Array
        @year.holidays[month].each do |holiday|
          holidays.push(holiday)
        end
      end

      holidays
    end

  private

    def next_month
      if @m == 12
        @m = 1
        @y += 1
        @d = 1
      else
        @m += 1
        @d = 1
      end

      @year = FinnishHolidays::Year.new(@y)
    end
  end
end
