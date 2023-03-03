module SystemSupport
  
  def login(user)
    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password"
    click_button "rspec_login_button"
  end
  
  def register_category
    big_categories = [:japan, :asia, :oceania, :north_america, :europe, :other ]
    big_categories.each do |big_category|
      create(big_category)
    end
  end
  
  def create_follow_relationships
      create(:relationship1)
      create(:relationship2)
  end
end