require_relative 'classes/calendar'

module FinnishHolidays
  # Lists the next holidays relative to today's date
  def self.next(count = 3, include_weekends = false)
    Calendar.new.next(count, include_weekends)
  end

  # Lists holidays for the given year
  def self.year(year, include_weekends = false)
    Calendar.new(year, 1, 1).year(year, include_weekends)
  end
end
