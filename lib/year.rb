require 'nokogiri'
require 'open-uri'
require 'json'
require 'time'
require_relative 'date_utils'

class Year
  def holidays()
    @holidays
  end

  def initialize(year)
    if year.is_a? Integer and year > 0
      @year = year.to_i
      @holidays = Hash.new { |hash, key| hash[key] = [] }
      self.load_data()
    else
      raise "Invalid year: #{year}"
    end
  end

  def load_data()
    file = self.get_file_path()

    if File.exist?(file)
      self.load_from_file()
    else
      self.parse_from_web()
      self.cache()
    end
  end

  def load_from_file()
    json = File.read(self.get_file_path())
    @holidays = JSON.parse(json)
  end

  def parse_from_web()
    page = Nokogiri::HTML(open('http://www.webcal.fi/fi-FI/pyhat.php?y=' + @year.to_s))

    page.css('table.basic tr').each do |el|
      if el.css('th:last-child').text != 'Päivämäärä' # TODO: Improve check.
        date_el = el.css('td:nth-child(4)')
        description_el = el.css('td:nth-child(2)')

        month = DateUtils.get_month(date_el.text).to_i
        day = DateUtils.get_day(date_el.text).to_i
        description = description_el.text

        self.add_holiday(@year, month, day, description)
      end
    end
  end

  def add_holiday(year, month, day, description)
    if !defined? @holidays[month]
      @holidays[month] = Array.new
    end

    holiday = {
      :year => year,
      :month => month,
      :day => day,
      :description => description
    }

    @holidays[month].push(holiday)
  end

  def cache()
    File.write(self.get_file_path(), @holidays.to_json)
  end

  def get_file_path()
    return File.dirname(__FILE__) + "/../data/#{@year}.json"
  end
end
