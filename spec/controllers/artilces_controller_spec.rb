# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:user) { create :user }
  # help for me from team!
  let!(:article) { create :article, user_id: user.id }

  let(:valid_article_params) do
    { article: { title: article.title,
                 body: article.body },
      user_id: article.user_id,
      id: article.id }
  end

  let(:invalid_article_params) do
    { article: { title: article.title,
                 body: nil }, user_id: article.user_id, id: article.id }
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

  describe '[POST] #create' do
    context 'with successful response' do
      let(:create_request) { post :create, params: valid_article_params }

      it { expect(create_request).to redirect_to user_articles_url(user_id: article.user_id) }
      it { expect { create_request }.to change(Article, :count).by(1) }
    end

    context 'with error' do
      before { post :create, params: invalid_article_params }

      it { expect(response).to render_template(:new) }
    end
  end

  describe '[PATH] #update' do
    context 'with successfully response' do
      before do
        patch :update, params: valid_article_params
      end

      it { expect(response).to redirect_to user_articles_path(user_id: user.id) }
    end
    context 'with error' do
      before { patch :update, params: invalid_article_params }

      it { expect(response).to render_template(:edit) }
    end
  end

  describe '[DELETE] #destroy' do
    context 'with successfully ' do
      let(:delete_article) { delete :destroy, params: { user_id: user.id, id: article.id } }
      it { expect(delete_article).to redirect_to user_articles_path(user_id: user.id) }
      it { expect { delete_article }.to change(Article, :count).by(-1) }
    end
  end
end
