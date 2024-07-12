require 'rails_helper'

RSpec.describe Movie, type: :model do
  it 'は、概要に改行コードを含めた場合、正しく反映されること' do
    text = '改行テスト\改行テスト'
    movie = FactoryBot.create(:movie, description: text)

    expect(movie.reload.description).to eq(text)
  end

  it 'は、重複したタイトルを設定する場合、登録できないこと' do
    movie = FactoryBot.create(:movie)
    other_movie = FactoryBot.build(:movie, name: movie.name)

    other_movie.valid?
    expect(other_movie.errors[:name]).to include('はすでに存在します')
  end
end
