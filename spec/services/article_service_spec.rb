# frozen_string_literal: true

require 'rails_helper'


RSpec.describe ArticleService  do
  let(:string_for_refactoring) { 'ruby rails frontend qa' }
  let(:final_string) { 'ruby rails frontend qa' }
=begin
  describe '#heck_title_and_body' do
    context ' with successfully refactor ' do
      before do
        @article_service = ArticleService.new
      end

      it { expect(@article_service.call(string_for_refactoring)).to eq(final_string) }
    end
=end
  end
end
