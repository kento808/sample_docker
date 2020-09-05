require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) }
  let(:invalid_user) { build(:user, username: 'ruby', email: '', password: 'password')}
  let(:invalid_user2) { build(:user, username: "a" * 51, email: 'email', password: 'password')}
  let(:invalid_user3) { build(:user, profile: "a" * 501) }

  it 'valid user' do
    user.valid?
    expect(user).to be_valid
  end

  it 'validates presence' do
    invalid_user.valid?
    expect(invalid_user.errors[:email]).to include("can't be blank")
  end

  it 'validates user maximum' do
    invalid_user2.valid?
    expect(invalid_user2.errors[:username]).to include("is too long (maximum is 50 characters)")
  end

  it 'validates user profile maximum' do
    invalid_user3.valid?
    expect(invalid_user3.errors[:profile]).to include("is too long (maximum is 500 characters)")
  end
end
