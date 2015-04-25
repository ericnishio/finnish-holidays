require_relative 'calendar'

module FinnishHolidays
  def holidays(count = 3, all = false)
    Calendar.new.holidays
  end
end
