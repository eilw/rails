require 'rails_helper'

feature 'Users can sign in and sign out' do
  context 'users not signed, and on the homepage' do
    scenario 'users should see a sign in link and a sign up link' do
      visit ('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    scenario 'users should not see a sign out link' do
      visit ('/')
      expect(page).not_to have_link('Sign out')
    end

    scenario 'users should not be able to add a restaurant if not logged in' do
      visit ('/')
      click_link('Add a restaurant')
      expect(current_path).not_to eq(new_restaurant_path)
    end
  end

  context 'users signed in on the homepage' do
    before do
      visit ('/')
      click_link('Sign up')
      fill_in('Email',with: 'test@example.com')
      fill_in('Password',with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    scenario 'should see a sign-out link' do
      visit ('/')
      expect(page).to have_link('Sign out')
    end

    scenario 'should not see a sign in or sign out link' do
      visit ('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

  end
end
