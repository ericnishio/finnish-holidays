require 'date'
require 'optparse'
require_relative 'date_utils'
require_relative 'translate'
require_relative 'version'
require_relative '../finnish-holidays'

module FinnishHolidays
  module CLI
    def self.run()
      options = {}

      optparse = OptionParser.new do |opts|
        options[:count] = 3
        opts.on('-cCOUNT', '--count=COUNT', 'Number of holidays to list') do |count|
          options[:count] = count.to_i
        end

        options[:include_weekends] = false
        opts.on('-a', '--all', 'Include holidays falling on a weekend') do
          options[:include_weekends] = true
        end

        opts.on('-h', '--help', 'Show this screen') do
          puts opts
          exit 0
        end

        opts.on('-v', '--version', 'Show version') do
          puts FinnishHolidays::VERSION
          exit 0
        end

        options[:year] = nil
        opts.on('-yYEAR', '--year=YEAR', 'List holidays by year') do |year|
          options[:year] = year.to_i
        end

        options[:month] = nil
        opts.on('-mMONTH', '--month=MONTH', 'List holidays by month') do |month|
          options[:month] = month.to_i
        end

        options[:language] = nil
        opts.on('-lLANGUAGE', '--language=LANGUAGE', 'Translate holidays (fi|sv)') do |language|
          if !['fi', 'sv'].include? language
            puts 'Language must be fi (Finnish) or sv (Swedish).'
            exit 1
          end

          options[:language] = language
        end
      end

      optparse.parse!

      if (options[:month].is_a? Integer) && (!options[:year].is_a? Integer)
        puts 'You must also specify a year with --year=YEAR'
        exit 1
      elsif (options[:year].is_a? Integer) && (options[:month].is_a? Integer)
        holidays = FinnishHolidays.month(options[:month], options[:year], options[:include_weekends])
      elsif options[:year].is_a? Integer
        holidays = FinnishHolidays.year(options[:year], options[:include_weekends])
      else
        holidays = FinnishHolidays.next(options[:count], options[:include_weekends])
      end

      holidays.each do |holiday|
        d = Date.new(holiday['year'], holiday['month'], holiday['day'])
        date = d.strftime('%a, %b %e, %Y')
        description = holiday['description']

        if ['fi', 'sv'].include? options[:language]
          description = FinnishHolidays::Translate.into(options[:language], holiday['description'])
        end

        puts "#{date} #{description}"
      end
    end
  end
end
