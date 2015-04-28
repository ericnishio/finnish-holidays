require_relative 'classes/calendar'

module FinnishHolidays
  # Lists the next holidays relative to today's date
  def self.next(count = 3, include_weekends = false)
    Calendar.new.next(count, include_weekends)
  end

  # Lists holidays for the given year
  def self.year(year, include_weekends = false)
    FinnishHolidays::Calendar.new(year, 1, 1).year(year, include_weekends)
  end

  # Lists holidays for the given month (and year)
  def self.month(month, year, include_weekends = false)
    FinnishHolidays::Calendar.new(year, month, 1).month(month, year, include_weekends)
  end
end
