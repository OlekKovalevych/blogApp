# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticleService do
  let(:string_for_refactoring) { 'ruby rails frontend qa' }
  let(:final_string) { 'Ruby Rails' }
  let(:article) { Article.new(title: string_for_refactoring, body: string_for_refactoring) }
  let(:service) { ArticleService.new(article: article) }
  describe '#heck_title_and_body' do
    context ' with successfully refactor ' do
      it { expect(service.call.title).to eq(final_string) }
      it { expect(service.call.body).to eq(final_string) }
    end
  end
end
