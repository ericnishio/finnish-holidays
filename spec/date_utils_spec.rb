require_relative 'spec_helper'

describe FinnishHolidays::DateUtils do
  it 'should detect Saturday' do
    is_weekend = FinnishHolidays::DateUtils.is_weekend(2015, 4, 25)
    expect(is_weekend).to be(true)
  end

  it 'should detect Sunday' do
    is_weekend = FinnishHolidays::DateUtils.is_weekend(2015, 4, 26)
    expect(is_weekend).to be(true)
  end

  it 'should not detect Fridays' do
    is_weekend = FinnishHolidays::DateUtils.is_weekend(2015, 4, 24)
    expect(is_weekend).not_to be(true)
  end

  it 'should place zero before single-digit integer' do
    number = FinnishHolidays::DateUtils.zerofy(1)
    expect(number).to eq('01')
  end

  it 'should not place zero before two-digit integer' do
    number = FinnishHolidays::DateUtils.zerofy(10)
    expect(number).to eq('10')
  end

  it 'should stringify single-digit integer' do
    number = FinnishHolidays::DateUtils.zerofy(9)
    expect(number).to be_kind_of(String)
  end

  it 'should stringify two-digit integer' do
    number = FinnishHolidays::DateUtils.zerofy(10)
    expect(number).to be_kind_of(String)
  end

  it 'should determine Easter Sunday in 2015' do
    expected_date = Date.new(2015, 4, 5)
    expect(FinnishHolidays::DateUtils.easter_sunday(2015)).to eq(expected_date)
  end

  it 'should determine Easter Monday in 2016' do
    expected_date = Date.new(2016, 3, 28)
    expect(FinnishHolidays::DateUtils.easter_monday(2016)).to eq(expected_date)
  end

  it 'should determine Good Friday in 2017' do
    expected_date = Date.new(2017, 4, 14)
    expect(FinnishHolidays::DateUtils.good_friday(2017)).to eq(expected_date)
  end

  it 'should determine Ascension Day in 2018' do
    expected_date = Date.new(2018, 5, 10)
    expect(FinnishHolidays::DateUtils.ascension_day(2018)).to eq(expected_date)
  end

  it 'should determine Pentecost in 2019' do
    expected_date = Date.new(2019, 6, 9)
    expect(FinnishHolidays::DateUtils.pentecost(2019)).to eq(expected_date)
  end

  it 'should determine Midsummer Eve in 2020' do
    expected_date = Date.new(2020, 6, 19)
    expect(FinnishHolidays::DateUtils.midsummer_eve(2020)).to eq(expected_date)
  end

  it 'should determine Midsummer Day in 2021' do
    expected_date = Date.new(2021, 6, 26)
    expect(FinnishHolidays::DateUtils.midsummer_day(2021)).to eq(expected_date)
  end

  it "should determine All Saints' Day in 2022" do
    expected_date = Date.new(2022, 11, 5)
    expect(FinnishHolidays::DateUtils.all_saints_day(2022)).to eq(expected_date)
  end
end
