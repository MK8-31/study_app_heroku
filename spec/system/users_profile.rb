require 'rails_helper'

RSpec.describe 'プロファイルテスト',type: :system do
    include TestHelper
    
    before do
        @user = create(:user)
        log_in_as(@user)
    end

    subject { page }

    scenario "プロファイルの構成確認" do
        visit user_path(@user)
        is_expected.to have_selector 'h1',text: @user.name
        is_expected.to have_selector 'h1>img.gravatar'
    end
end