require 'rails_helper'
require_relative './helpers/features_spec_helper'


feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    sign_up_and_review

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'a user can only leave one review per restaurant' do
    sign_up_and_review
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: 'hmmm'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content('You can only review a restaurant once')
  end

  scenario 'users can delete reviews' do
    sign_up_and_review
    visit '/restaurants'
    click_link 'Delete review'
    expect(page).not_to have_content('so so')
  end

  scenario 'users can only their own reviews' do
    sign_up_and_review
    sign_up_with_second_user
    visit '/restaurants'
    click_link 'Delete review'
    expect(page).to have_content('so so')
  end
end
