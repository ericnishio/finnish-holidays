#!/usr/bin/env ruby

require_relative '../lib/calendar.rb'

if (defined? ARGV[0] and ARGV[0].to_i > 0)
  count = ARGV[0].to_i
else
  count = 3
end

Calendar.new.holidays_print(count)
