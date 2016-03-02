require 'rails_helper'

describe Restaurant, type: :model do
  it {is_expected.to have_many(:reviews).dependent(:destroy)}
  it {is_expected.to belong_to :user}

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

describe 'reviews' do
  describe 'build_with_user' do

    let(:user) { User.create email: 'test@test.com' }
    let(:restaurant) { Restaurant.create name: 'Test' }
    let(:review_params) { {rating: 5, thoughts: 'yum'} }

    subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

    it 'builds a review' do
      expect(review).to be_a Review
    end

    it 'builds a review associated with the specified user' do
      expect(review.user).to eq user
    end
  end
end
