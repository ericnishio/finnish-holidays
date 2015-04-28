require_relative 'spec_helper'

describe DateUtils do
  it 'should detect Saturday' do
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
