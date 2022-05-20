# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do

  it 'Is invalid when body length less then 10' do
    expect(FactoryBot.build(:article, body: 'TWO')).to_not be_valid, 'I valid'
  end

  it 'Is valid with title and body' do
    expect(FactoryBot.build(:article)).to_not be_valid, 'Is valid'
  end

  it 'Is invalid without title ' do
    expect(FactoryBot.build(:article, title: nil)).to_not be_valid
  end

  it 'Is invalid without body ' do
    expect(FactoryBot.build(:article, body: nil)).to_not be_valid
  end
end
