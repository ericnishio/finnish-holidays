class DateUtils
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
    day_of_week == 6 or day_of_week == 7
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
