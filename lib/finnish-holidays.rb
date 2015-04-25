require_relative 'calendar'

class FinnishHolidays
  def self.holidays(count = 3, all = false)
    Calendar.new.holidays
  end
end
