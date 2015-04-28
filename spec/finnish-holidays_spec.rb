require_relative 'spec_helper'

describe FinnishHolidays do
  it 'should return non-weekend holidays in 2015' do
    holidays = FinnishHolidays.year(2015)
    expect(holidays.length).to eq(9)
  end

  it 'should return all holidays in 2015' do
    holidays = FinnishHolidays.year(2015, true)
    expect(holidays.length).to eq(15)
  end
end
