require 'acceptance/acceptance_helper'

feature 'User can see share buttons', '
  In order to share plan on social networks
  As an authenticated user
  I want to see share buttons
' do

  given(:user) { create(:user) }
  given(:plan) { create(:plan, user: user) }

  scenario 'User tries to see buttons' do
    sign_in user
    visit user_plan_path(user, plan)

    %w[
      twitter facebook google_plus weibo qq douban
      google_bookmark delicious tumblr pinterest email
      linkedin wechat vkontakte xing reddit hacker_news
      telegram odnoklassniki
    ].each do |network|
      expect(page).to have_css("a[data-site=#{network}]")
    end
  end
end
