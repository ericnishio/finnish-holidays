require 'nokogiri'
require 'open-uri'
require 'json'
require 'time'
require_relative '../utils/date-utils'

class Year
  def initialize(year)
    if year.is_a? Integer and year > 0
      @year = year.to_i
      @holidays = {}
      load_data()
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

  def load_data
    file = get_cache_file_path()

    if File.exist?(file)
      load_from_file()
    else
      load_from_web()
      cache()
    end
  end

  def load_from_file
    json = File.read(get_cache_file_path())
    @holidays = JSON.parse(json)
  end

  def load_from_web
    page = Nokogiri::HTML(open('http://www.webcal.fi/fi-FI/pyhat.php?y=' + @year.to_s))

    page.css('table.basic tr').each do |el|
      if el.css('th:last-child').text != 'Päivämäärä' # TODO: Improve check.
        date_el = el.css('td:nth-child(4)')
        description_el = el.css('td:nth-child(2)')

        month = DateUtils.parse_month(date_el.text)
        day = DateUtils.parse_day(date_el.text)
        description = description_el.text

        add_holiday(@year, month, day, description)
      end
    end
  end

  def add_holiday(year, month, day, description)
    year = year.to_i
    month = month.to_i
    day = day.to_i

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

  def cache
    File.write(get_cache_file_path(), @holidays.to_json)
  end

  def get_cache_file_path
    cwd = File.dirname(__FILE__)
    "#{cwd}/../../data/#{@year}.json"
  end
end
