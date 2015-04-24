require 'nokogiri'
require 'open-uri'
require 'json'

class Holidays
  @y = nil
  @m = nil
  @d = nil
  @year = nil

  def initialize
    @y = Time.now.year
    @m = Time.now.month
    @d = Time.now.day
    @year = Year.new(@y)
  end

  def next count = 3
    holidays = Array.new

    while holidays.length < count
      month_index = @m.to_s

      if defined? @year.get_holidays[month_index]
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

  def next_json count = 3
    self.next(count).to_json
  end

  def next_print count = 3
    holidays = self.next(count)
    holidays.each do |holiday|
      puts "#{holiday['day']}.#{holiday['month']}.#{holiday['year']} #{holiday['description']}"
    end
  end

  def goto_next_month
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

        month = self.get_month(date_el.text).to_s
        day = self.get_day(date_el.text).to_s
        description = description_el.text.to_s

        if !defined? @holidays[month]
          @holidays[month] = Array.new
        end

        holiday = {
          'day' => day.to_i,
          'month' => month.to_i,
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
    return "./data/#{@year}.json"
  end

  def get_holidays
    @holidays
  end

  def get_json
    self.get_holidays.to_json
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
