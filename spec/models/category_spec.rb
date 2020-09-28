require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @category = Category.new(name: 'グルメ')
  end

  it 'valid category' do
    @category.valid?
    expect(@category).to be_valid
  end

  it 'invalid presence' do
    @category.name = nil
    @category.valid?
    expect(@category).to be_invalid
  end
end
