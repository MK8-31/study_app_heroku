require 'rails_helper'

RSpec.describe Subject, type: :model do
  before do
    @user = create(:user)
    @subject = @user.subjects.create!(name: "math",day_of_week: "Monday",th_period: 1,definitely: true)
  end

  describe 'Subjectバリデーション' do
    
    it 'nameが空だとNG' do
      @subject.name = " "
      expect(@subject.valid?).to eq(false)
    end

    it "day_of_weekが空だとNG" do
      @subject.day_of_week = " "
      expect(@subject.valid?).to eq(false)
    end

    it "th_periodが空だとNG" do
      @subject.th_period = " "
      expect(@subject.valid?).to eq(false)
    end

    it "day_of_weekとth_periodの組み合わせは一意" do
      @subjectdup = @user.subjects.create(name: "math",day_of_week: "Monday",th_period: 1,definitely: true)
      expect(@subjectdup.valid?).to eq(false)
    end

    it "th_periodは1~6の間" do
      @subjecterror = @user.subjects.create(name: "math",day_of_week: "Monday",th_period: 7,definitely: true)
      expect(@subjecterror.valid?).to eq(false)
    end
  end
end
