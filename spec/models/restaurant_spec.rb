require 'rails_helper'

describe Restaurant, type: :model do
  it {is_expected.to have_many(:reviews).dependent(:destroy)}

  it 'is not valid with a name less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
  end

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: 'Dougs Donuts')
    restaurant = Restaurant.new(name: 'Dougs Donuts')
    expect(restaurant).to have(1).error_on(:name)
  end
end
