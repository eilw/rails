require 'rails_helper.rb'
require_relative './helpers/features_spec_helper'

feature 'endorsing reviews' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    sign_up_and_review('it was awful', 3)
  end

  scenario 'a user can endorse a review, which updates the review endorsement count', js:true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 endorsement')
  end

  scenario 'Keeps track of the num of endorsements', js:true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 endorsement')
    click_link 'Endorse'
    expect(page).to have_content('2 endorsements')
    click_link 'Endorse'
    expect(page).to have_content('3 endorsements')
    click_link 'Endorse'
    expect(page).to have_content('4 endorsements')
  end

end
