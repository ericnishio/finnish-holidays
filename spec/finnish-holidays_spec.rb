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

  it 'year should return valid holiday object' do
    holidays = FinnishHolidays.year(2016, true)

    expected_holiday = {
      'year' => 2016,
      'month' => 1,
      'day' => 1,
      'description' => "New Year's Day"
    }

    expect(holidays[0] == expected_holiday)
  end

  it 'month should return valid holiday object' do
    holidays = FinnishHolidays.month(12, 2015, true)

    expected_holiday = {
      'year' => 2015,
      'month' => 12,
      'day' => 6,
      'description' => 'Independence Day'
    }

    expect(holidays[0] == expected_holiday)
  end
end
