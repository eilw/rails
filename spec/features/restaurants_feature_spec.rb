require 'rails_helper.rb'
require_relative './helpers/features_spec_helper'

feature 'restaurants' do

	context 'no restaurants have been added' do
		scenario 'should display a prompt to add a restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'No restaurant yet!'
			expect(page).to have_link 'Add a restaurant'
		end
	end

	context 'restaurants have been added' do
		before do
			Restaurant.create(name: 'KFC')
		end

		scenario 'display restaurants' do
			visit '/restaurants'
			expect(page).to have_content('KFC')
			expect(page).not_to have_content('No restaurant yet!')
		end
	end

	context 'creating restaurants' do
		scenario 'prompts user to fill out a form, then displays the new restaurant' do
			sign_up_helper
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq '/restaurants'
		end

		scenario 'can upload a picture' do
			sign_up_helper
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			attach_file 'Image', Rails.root + 'spec/features/images/hammericon.png'
			click_button 'Create Restaurant'
			expect(page).to have_xpath("//img[@src=\"/html/body/img[1]\"]")
		end

		context 'creating an invalid restaurant' do
			scenario 'does not let you submit a name that is too short' do
				sign_up_helper
				visit '/restaurants'
				click_link 'Add a restaurant'
				fill_in 'Name', with: 'kf'
				click_button 'Create Restaurant'
				expect(page).not_to have_css('h2', text: 'kf')
				expect(page).to have_content 'error'
			end
		end
	end

	context 'view restaurants' do
		let!(:kfc){Restaurant.create(name:'KFC')}

		scenario 'lets a user view a restaurant' do
			visit '/restaurants'
			click_link 'KFC'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq "/restaurants/#{kfc.id}"
		end
	end

	context 'edit restaurants' do
		before do
			sign_up_helper
			user = User.find_by(email: 'test@example.com')
			rest = Restaurant.create name: 'KFC', user_id: user.id
		end

		scenario 'users can edit the ones they have created ' do
			visit '/restaurants'
			click_link 'Edit KFC'
			fill_in 'Name', with: 'Kentucky Fried Chicken'
			click_button 'Update Restaurant'
			expect(page).to have_content 'Kentucky Fried Chicken'
			expect(current_path).to eq '/restaurants'
		end

		scenario 'users can not edit another users restaurants' do
			sign_up_with_second_user
			visit '/restaurants'
			click_link 'Edit KFC'
			expect(page).to have_content 'You are not authorised to change'
		end
	end

	context 'deleting restaurants' do
		before do
			sign_up_helper
			user = User.find_by(email: 'test@example.com')
			rest = Restaurant.create name: 'KFC', user_id: user.id
		end

		scenario 'removes a restaurant when a user clicks a delete link' do
			visit '/restaurants'
			click_link 'Delete KFC'
			expect(page).not_to have_content 'KFC'
			expect(page).to have_content 'Restaurant deleted successfully'
		end

		scenario 'A user can only delete a restaurant they have created' do
			sign_up_with_second_user
			visit '/restaurants'
			click_link 'Delete KFC'
			expect(page).to have_content 'KFC'
			expect(page).to have_content 'You are not authorised to change'
		end
	end

end
