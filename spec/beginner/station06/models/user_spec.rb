require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe 'validate' do
    it 'は、有効な属性を持っている場合、有効であること' do
      expect(user).to be_valid
    end

    it 'は、emailがない場合、無効であること' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'は、emailが255文字を超える場合、無効であること' do
      user.email = "#{'a' * 244}@example.com"
      expect(user).to_not be_valid
    end

    it 'は、emailが重複する場合、無効であること' do
      FactoryBot.create(:user, email: user.email)
      expect(user).to_not be_valid
    end

    it 'は、無効な形式のemailの場合、無効であること' do
      user.email = 'invalid_email'
      expect(user).to_not be_valid
    end

    it 'は、nameがない場合、無効であること' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'は、nameが50文字を超える場合、無効であること' do
      user.name = 'a' * 51
      expect(user).to_not be_valid
    end
  end
end
