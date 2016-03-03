 #TODO could refacto this by just directly creating a user, and then logging in, in particular for the second user
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

  def sign_up_and_review(thoughts, rating)
    sign_up_helper
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  def leave_review(thoughts,rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end
