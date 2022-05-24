# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
  end
end
