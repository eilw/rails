require 'rails_helper'

describe Review, type: :model do
  it {is_expected.to belong_to :restaurants}
end
