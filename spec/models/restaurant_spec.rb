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

describe '#average_rating' do
  let(:user) { User.create email: 'test@test.com', password: '12345678' }
  let(:user2) { User.create email: 'test2@test.com', password: '12345678' }
  # let(:restaurant) { Restaurant.create name: 'The Ivy' }
  # let(:review_params) { {rating: 5, thoughts: 'yum'} }
  #
  # subject(:review) { restaurant.reviews.build_with_user(review_params, user) }


  context 'no reviews' do
    it 'returns N/A when there is no reviews' do
      restaurant = Restaurant.create(name: 'The Ivy')
      expect(restaurant.average_rating).to be nil
    end
  end

  context 'multiple reviews' do
    it 'returns the average' do
      restaurant = Restaurant.create(name: 'The Ivy')
      restaurant.reviews.create(rating:3, user: user)
      restaurant.reviews.create(rating:5, user: user2)
      expect(restaurant.average_rating).to eq 4
    end
  end
end
