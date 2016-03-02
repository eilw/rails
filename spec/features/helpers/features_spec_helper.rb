
  def sign_up_helper
    visit ('/')
    click_link('Sign up')
    fill_in('Email',with: 'test@example.com')
    fill_in('Password',with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  def sign_up_with_second_user
    click_link('Sign out')
    visit ('/')
    click_link('Sign up')
    fill_in('Email',with: 'test2@example.com')
    fill_in('Password',with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  def sign_up_and_review
    sign_up_helper
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
  end
