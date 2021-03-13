require 'rails_helper'

RSpec.describe 'Home', type: :system do
    it 'shows greeting' do
        visit root_path
        expect(page).to have_content "最高の時間管理を"
        expect(page).to have_content "あなたに"
        visit login_path
        expect(page).to have_content "Log in"

    end
end