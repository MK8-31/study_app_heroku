require 'rails_helper'

RSpec.describe Studytime, type: :model do
  before do
    @user = create(:user)
    @studytime = @user.studytimes.create!(day: Date.today,time: 30,ctime: 20)
  end

  describe 'Studytimeバリデーション' do
    it 'dayが空だとNG' do
      @studytime.day = " "
      expect(@studytime.valid?).to eq(false)
    end

    it 'timeが空だとNG' do
      @studytime.time = " "
      expect(@studytime.valid?).to eq(false)
    end

    it 'ctimeが空だとNG' do
      @studytime.ctime = " "
      expect(@studytime.valid?).to eq(false)
    end

    it 'ctimeはtimeよりも小さい' do
      @studytime.ctime = 60
      expect(@studytime.valid?).to eq(false)
    end

    it 'dayは一意' do
      @studytimedup = @user.studytimes.create(day: Date.today,time: 30,ctime: 20)
      expect(@studytimedup.valid?).to eq(false)
    end
  end
end
