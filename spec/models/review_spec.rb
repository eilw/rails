require 'rails_helper'

describe Review, type: :model do
  it {is_expected.to belong_to :restaurant}

  it 'is invalid if rating is more than five' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end
