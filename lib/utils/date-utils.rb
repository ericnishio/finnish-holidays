require 'date'

class DateUtils
  FRIDAY = 5
  SATURDAY = 6
  SUNDAY = 7

  def self.is_weekend(year, month, day)
    t = Date.new(year, month, day)
    day_of_week = t.strftime('%u').to_i
    [SATURDAY, SUNDAY].include? day_of_week
  end

  def self.get_midsummer_eve(year)
    [19, 20, 21, 22, 23, 24, 25].each do |day|
      day_of_week = Date.new(year, 6, day).strftime('%u').to_i
      if day_of_week == FRIDAY
        return Date.new(year, 6, day)
      end
    end
  end

  def self.get_easter_sunday(year)
    a = year % 19
    b = year / 100
    c = year % 100
    d = b / 4
    e = b % 4
    f = (b + 8) / 25
    g = (b - f + 1) / 3
    h = (19 * a + b - d - g + 15) % 30
    i = c / 4
    k = c % 4
    l = (32 + 2 * e + 2 * i - h - k) % 7
    m = (a + 11 * h + 22 * l) / 451
    x = h + l - 7 * m + 114
    month = x / 31
    day = (x % 31) + 1
    Date.new(year, month, day)
  end

  def self.get_year_from_date(date)
    date.strftime('%Y').to_i
  end

  def self.get_month_from_date(date)
    date.strftime('%-m').to_i
  end

  def self.get_day_from_date(date)
    date.strftime('%-d').to_i
  end

  def self.zerofy(num)
    num = num.to_i

    if num < 10
      num = '0' + num.to_s
    else
      num = num.to_s
    end

    num
  end
end
