require 'rails_helper'
require_relative './helpers/features_spec_helper'


feature 'reviewing' do

  context('A user is signed in after a restaurant is created') do

    before {Restaurant.create name: 'KFC'}

    scenario 'allows users to leave a review using a form' do
      sign_up_and_review('so so', 3)

      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('so so')
    end

    scenario 'a user can only leave one review per restaurant' do
      sign_up_and_review('so so', 3)
      visit '/restaurants'
      expect(page).not_to have_link('Review KFC')
    end

    scenario 'users can delete reviews' do
      sign_up_and_review('so so', 3)
      visit '/restaurants'
      click_link 'Delete review'
      expect(page).not_to have_content('so so')
    end

    scenario 'users can only their delete their own reviews' do
      sign_up_and_review('so so', 3)
      sign_up_with_second_user
      visit '/restaurants'
      expect(page).not_to have_link('Delete review')
      # expect(page).to have_content('so so')
    end

    scenario 'each review contains the mail address of the reviewer' do
      sign_up_and_review('so so', 3)
      visit('/restaurants')
      expect(page).to have_content('test@example.com')
    end
  end

  context 'A user creates the restaurant' do
    before do
			sign_up_helper
			user = User.find_by(email: 'test@example.com')
			rest = Restaurant.create name: 'KFC', user_id: user.id
		end

    scenario 'a user cannot review a restaurant they created' do
      expect(page).not_to have_link('Review KFC')
    end
  end

  context 'restaurant create that is not owned' do
    before do
      Restaurant.create name: 'KFC'
		end

    scenario 'displays an average rating for all reviews' do
      sign_up_and_review('so so', 3)
      sign_up_with_second_user
      leave_review('great', 5)
      expect(page).to have_content('Average rating: ★★★★☆')
    end

    scenario 'shows the time ago of a review' do
      new_time = Time.local(2016, 1, 1, 12, 0, 0)
      Timecop.travel(-3600)
      sign_up_and_review('so so', 3)
      Timecop.return
      visit('/')
      expect(page).to have_content('about 1 hour')
    end

  end

end
