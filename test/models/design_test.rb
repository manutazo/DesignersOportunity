require 'test_helper'

RSpec.describe Design, type: :model do
  let(:current_user){create(:user)}
    let(:design_assigned){create(:design, user: current_user)}


    it 'is invalid without a title' do
      expect(build(:design, title: nil)).to_not be_valid
    end

    it 'is invalid without an author' do
      expect(build(:design, description: nil)).to_not be_valid
    end

    it 'is invalid without an author' do
      expect(build(:design, image: nil)).to_not be_valid
    end

    it 'is invalid without an author' do
      expect(build(:design, user_id: nil)).to_not be_valid
    end

    it 'is invalid without an author' do
      expect(build(:design, user_id: "string")).to_not be_valid
    end

    it 'is invalid without an author' do
      expect(build(:design, description: nil)).to_not be_valid
    end
