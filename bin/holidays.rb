#!/usr/bin/env ruby

require 'optparse'
require_relative '../lib/calendar'

options = {}

optparse = OptionParser.new do |opts|
  options[:count] = 3
  opts.on('-cCOUNT', '--count=COUNT', 'Number of holidays to show') do |count|
    options[:count] = count.to_i
  end

  options[:all] = false
  opts.on('-a', '--all', 'Show all holidays') do
    options[:all] = true
  end

  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end

optparse.parse!

Calendar.new.holidays_print(options[:count])
