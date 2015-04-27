require 'date'
require_relative '../utils/date-utils'

class Year
  def initialize(year)
    if year > 0
      @year = year
      @holidays = {}
      load_holidays()
    else
      raise "Invalid year: #{year}"
    end
  end

  def holidays
    @holidays
  end

  def discard_weekends
    holidays = {}

    @holidays.each do |month, array|
      array.each do |holiday|
        if !DateUtils.is_weekend(holiday['year'], holiday['month'], holiday['day'])
          if !holidays[month].is_a? Array
            holidays[month] = []
          end

          holidays[month].push(holiday)
        end
      end
    end

    @holidays = holidays
  end

private

  def load_holidays
    # Holidays must be added in order
    add_holiday(Date.new(@year, 1, 1), "New Year's Day")
    add_holiday(Date.new(@year, 1, 6), 'Epiphany')
    add_holiday(DateUtils.good_friday(@year), 'Good Friday')
    add_holiday(DateUtils.easter_sunday(@year), 'Easter Sunday')
    add_holiday(DateUtils.easter_monday(@year), 'Easter Monday')
    add_holiday(Date.new(@year, 1, 1), 'May Day')
    add_holiday(DateUtils.ascension_day(@year), 'Ascension Day')
    add_holiday(DateUtils.pentecost(@year), 'Pentecost')
    add_holiday(DateUtils.midsummer_eve(@year), 'Midsummer Eve (unofficial)')
    add_holiday(DateUtils.midsummer_day(@year), 'Midsummer Day')
    add_holiday(DateUtils.all_saints_day(@year), "All Saints' Day")
    add_holiday(Date.new(@year, 12, 6), 'Independence Day')
    add_holiday(Date.new(@year, 12, 24), 'Christmas Eve (unofficial)')
    add_holiday(Date.new(@year, 12, 25), 'Christmas Day')
    add_holiday(Date.new(@year, 12, 26), "St. Stephen's Day")
  end

  def add_holiday(date, description)
    year = DateUtils.get_year_from_date(date)
    month = DateUtils.get_month_from_date(date)
    day = DateUtils.get_day_from_date(date)

    if !@holidays[month].is_a? Array
      @holidays[month] = []
    end

    holiday = {
      'year' => year,
      'month' => month,
      'day' => day,
      'description' => description
    }

    @holidays[month].push(holiday)
  end
end
