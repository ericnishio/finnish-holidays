require 'json'
require 'time'
require_relative 'year'
require_relative 'date_utils'

class Calendar
  MAX_HOLIDAYS = 100

  def initialize()
    @y = Time.now.year
    @m = Time.now.month
    @d = Time.now.day
    @year = Year.new(@y)
  end

  def next(count = 3)
    if count > MAX_HOLIDAYS
      raise "Cannot request more than #{MAX_HOLIDAYS} holidays at once."
    end

    holidays = Array.new

    while holidays.length < count
      month_index = @m.to_s

      if defined? @year.get_holidays[month_index] and @year.get_holidays[month_index].is_a? Array
        @year.get_holidays[month_index].each do |holiday|
          if holidays.length < count and holiday['day'].to_i >= @d
            holidays.push(holiday)
          end
        end
      end

      if holidays.length < count
        self.goto_next_month()
      end
    end

    holidays
  end

  def next_json(count = 3)
    self.next(count).to_json
  end

  def next_print(count = 3)
    holidays = self.next(count)

    holidays.each do |holiday|
      t = DateUtils.create_date(holiday['year'], holiday['month'], holiday['day'])
      date = t.strftime('%a, %b %e, %Y')

      puts "#{date} #{holiday['description']}"
    end
  end

  def goto_next_month()
    if @m == 12
      @m = 1
      @y += 1
      @d = 1
    else
      @m += 1
      @d = 1
    end

    @year = Year.new(@y)
  end
end
