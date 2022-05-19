require 'rails_helper'

RSpec.describe Article, type: :model do
  subject { Article.new(title: 'Article', body: 'Test Article') }
  it 'Is not valid when body length lites 10' do
    subject.body = 'AS'
    expect(subject).to_not be_valid, 'I valid'
  end

  it 'Is not valid without title and body' do
    subject.title = nil
    subject.body = nil
    expect(subject).to_not be_valid, 'Is valid'
  end
end
