require_relative 'classes/calendar'

module FinnishHolidays
  def self.holidays(count = 3, all = false)
    Calendar.new.holidays(count, all)
  end
end
