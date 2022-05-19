require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Oleksandr', surname: 'Kovalevych') }
  it 'Is no valid without name and surname' do
    subject.name = nil
    subject.surname = nil
    expect(subject).to_not be_valid, 'Is valid '
  end
end
