require 'time'
require_relative 'spec_helper'

describe DateUtils do
  it 'should create a date' do
    date = DateUtils.create_date(2015, 4, 26).to_s[0...19] # discard timezone '+0300'
    expect(date).to eq('2015-04-26 00:00:00')
  end

  it 'should parse day from Finnish date' do
    day = DateUtils.parse_day('1.2.2015')
    expect(day).to eq(1)
  end

  it 'should parse month from Finnish date' do
    month = DateUtils.parse_month('1.2.2015')
    expect(month).to eq(2)
  end

  it 'should detect Satuday' do
    is_weekend = DateUtils.is_weekend(2015, 4, 25)
    expect(is_weekend).to be(true)
  end

  it 'should detect Sunday' do
    is_weekend = DateUtils.is_weekend(2015, 4, 26)
    expect(is_weekend).to be(true)
  end

  it 'should not detect Fridays' do
    is_weekend = DateUtils.is_weekend(2015, 4, 24)
    expect(is_weekend).not_to be(true)
  end

  it 'should place zero before single-digit integer' do
    number = DateUtils.zerofy(1)
    expect(number).to eq('01')
  end

  it 'should not place zero before two-digit integer' do
    number = DateUtils.zerofy(10)
    expect(number).to eq('10')
  end

  it 'should stringify single-digit integer' do
    number = DateUtils.zerofy(9)
    expect(number).to be_kind_of(String)
  end

  it 'should stringify two-digit integer' do
    number = DateUtils.zerofy(10)
    expect(number).to be_kind_of(String)
  end
end
