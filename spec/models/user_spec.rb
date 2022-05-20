# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = User.new(
      name: 'Test',
      surname: 'User'
    )
  end

  it 'is valid with a name and surname' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it 'is invalid without a first name' do
    expect(FactoryBot.build(:user, name: nil)).to_not be_valid, 'is valid'
  end

  it 'is invalid without a surname' do
    expect(FactoryBot.build(:user, surname: nil)).to_not be_valid, 'is valid'
  end

end
