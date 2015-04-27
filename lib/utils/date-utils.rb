class DateUtils
  FRIDAY = 5
  SATURDAY = 6
  SUNDAY = 7

  def self.create_date(year, month, day)
    day = self.zerofy(day)
    month = self.zerofy(month)
    year = year.to_s

    Time.parse("#{year}-#{month}-#{day}")
  end

  def self.parse_day(date_string)
    parts = date_string.split('.')
    parts[0].to_i
  end

  def self.parse_month(date_string)
     parts = date_string.split('.')
     parts[1].to_i
  end

  def self.is_weekend(year, month, day)
    t = self.create_date(year, month, day)
    day_of_week = t.strftime('%u').to_i
    [SATURDAY, SUNDAY].include? day_of_week
  end

  def self.get_midsummer_eve(year)
    [19, 20, 21, 22, 23, 24, 25].each do |day|
      day_of_week = self.create_date(year, 6, day).strftime('%u').to_i
      if day_of_week == FRIDAY
        return day
      end
    end
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
