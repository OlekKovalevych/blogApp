# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:user) { create :user }
  let(:article) { Article.new(title: 'QWERTYQWERTY', body: 'QWERTYUIOP', user_id: user.id) }

  before do
    article.save
  end

  describe '[GET] #index' do
    context 'with successful response' do
      before { get :index, params: { user_id: user.id } }
      it do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response).to render_template(:index)
      end
    end
  end

  describe '[GET] #show' do
    context 'with successful response' do
      before do
        get :show, params: { id: article.id, user_id: article.user_id }
      end

      it do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response).to render_template(:show)
      end
    end
  end

  describe '[POST] #create'
  let(:valid_article_params) do
    { article: { title: article.title,
                 body: article.body }, user_id: article.user_id }
  end
  let(:invalid_article_params) do
    { article: { title: article.title,
                 body: nil }, user_id: article.user_id }
  end
  context 'with successful response' do
    before do
      post :create, params: valid_article_params
    end

    it { expect(response).to redirect_to user_articles_url(user_id: article.user_id) }
  end
  context 'with error' do
    before { post :create, params: invalid_article_params }

    it { expect(response).to render_template(:new) }
  end

  describe '[PATH] #update'

  describe '[DELETE] destroy'
end
