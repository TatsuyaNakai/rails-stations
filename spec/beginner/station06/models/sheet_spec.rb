require 'rails_helper'

RSpec.describe Sheet, type: :model do
  it 'は、存在していること' do
    expect(defined?(Sheet)).to eq 'constant'
    expect(Sheet).to be_a(Class)
  end
end
