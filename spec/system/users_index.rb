require 'rails_helper'

RSpec.describe "user_index",type: :system do
    include TestHelper

    before do
        @admin = create(:user)
        @non_admin = create(:non_admin)
    end
    
    let(:users) { create_list(:add_user,30) }

    before do
        @users = users
    end

    scenario 'アドミンユーザーでログインするとページネーションと削除リンクがある' do
        log_in_as(@admin)
        visit users_path
        expect(page).to have_content "All users"
        expect(page).to have_selector 'div.pagination'
        first_page_of_users = User.paginate(page: 1,per_page: 10)
        first_page_of_users.each do |user|
            unless user == @admin
                expect(page).to have_content user.name
                expect(page).to have_link 'delete',href: user_path(user)
            end 
        end 
    end 

    scenario 'アドミンユーザーでユーザーを削除' do
        log_in_as(@admin)
        visit users_path
        expect(page).to have_content "#{@admin.name}"
        expect(page).to have_content "All users"
        user = User.second
        expect(page).to have_link "delete",href: user_path(user)
        expect{ 
            page.accept_confirm("You sure?") do
                find("#delete_button#{user.id}").click
            end
            expect(page).to have_content "User deleted!" #ajax通信完了のための時間稼ぎ
        }.to change{ User.count }.by(-1)
    end
end