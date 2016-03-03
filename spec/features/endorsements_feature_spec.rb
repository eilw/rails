require 'rails_helper.rb'
require_relative './helpers/features_spec_helper'

feature 'endorsing reviews' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    sign_up_and_review('it was awful', 3)
  end

  scenario 'a user can endorse a review, which updates the review endorsement count', js:true do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

  scenario 'The endorsment keeps track of the nr of endorsments' do
    visit '/restaurants'
    4.times {click_link 'Endorse Review'}
    expect(page).to have_content('4 endorsements')
  end

end
