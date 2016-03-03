require 'rails_helper'

describe ReviewsHelper, :type => :helper do
  context '#star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'retursn five black stars for five' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end

    it 'returns 2 black stars and three white star for 2' do
      expect(helper.star_rating(2)).to eq '★★☆☆☆'
    end

    it 'returns four black stars and one white star for 3.5' do
      expect(helper.star_rating(3.5)).to eq '★★★★☆'
    end
  end

  # context '#time_ago' do
  #   it 'returns ' do
  #
  #   end
  # end
end
