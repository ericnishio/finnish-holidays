require 'nokogiri'
require 'open-uri'
require 'json'
require 'time'

class Year
  @year = nil
  @holidays = nil

  def initialize year
    if year.is_a? Integer and year > 0
      @year = year.to_i
      @holidays = Hash.new { |hash, key| hash[key] = [] }
      self.load_data()
    else
      raise "Invalid year: #{year}"
    end
  end

  def load_data
    file = self.get_file_path()

    if File.exist?(file)
      self.load_from_file()
    else
      self.parse_holidays()
      self.cache_data()
    end
  end

  def load_from_file
    json = File.read(self.get_file_path())
    @holidays = JSON.parse(json)
  end

  def parse_holidays
    page = Nokogiri::HTML(open('http://www.webcal.fi/fi-FI/pyhat.php?y=' + @year.to_s))

    page.css('table.basic tr').each do |el|
      if el.css('th:last-child').text != 'Päivämäärä' # TODO: Improve check.
        date_el = el.css('td:nth-child(4)')
        description_el = el.css('td:nth-child(2)')

        month = self.get_month(date_el.text).to_i
        day = self.get_day(date_el.text).to_i
        description = description_el.text

        if !defined? @holidays[month]
          @holidays[month] = Array.new
        end

        holiday = {
          'day' => day,
          'month' => month,
          'year' => @year,
          'description' => description
        }

        @holidays[month].push(holiday)
      end
    end
  end

  def cache_data
    File.write(self.get_file_path(), @holidays.to_json)
  end

  def get_file_path
    return File.dirname(__FILE__) + "/../data/#{@year}.json"
  end

  def get_holidays
    @holidays
  end

  def get_json
    self.get_holidays.to_json
  end

  def create_date year, month, day
    day = self.zerofy(day)
    month = self.zerofy(month)
    year = year.to_s

    Time.parse("#{year}-#{month}-#{day}")
  end

  def zerofy num
    num = num.to_i

    if num < 10
      num = '0' + num.to_s
    else
      num = num.to_s
    end

    num
  end

  def get_day date_string
    parts = date_string.split('.')
    parts[0].to_i
  end

  def get_month date_string
     parts = date_string.split('.')
     parts[1].to_i
  end
end
