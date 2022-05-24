# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }
  let(:valid_update_user_params) do
    { id: user.id, user: { name: 'Name', surname: 'Surname' } }
  end
  describe '[GET] #index' do
    context 'with successful response' do
      before { get :index }

      it do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response).to render_template(:index)
      end
    end
  end

  describe '[GET] #show' do
    context 'with successful response' do
      before { get :show, params: { id: user.id } }

      it do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response).to render_template(:show)
      end
    end
  end

  describe '[POST] #create' do
    let(:valid_user_params) do
      { user: { name: 'Name', surname: 'Surname' } }
    end
    let(:invalid_user_params) do
      { user: { name: nil, surname: 'Surname' } }
    end
    context 'with successful response' do
      before { post :create, params: valid_user_params }

      it { expect(response).to redirect_to user_path(id: User.last.id) }
    end
    context 'with error' do
      before { post :create, params: invalid_user_params }

      it { expect(response).to render_template(:new) }
    end
  end

  describe '[PATH] #update' do
    context 'with successful response' do
      before { put :update, params: valid_update_user_params }
      it { expect(response).to redirect_to user_path(id: user.id) }
    end

    context 'with error' do
      let(:invalid_update_user_params) do
        { id: user.id, user: { name: nil, surname: 'surname' } }
      end
      before { put :update, params: invalid_update_user_params }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe '[DELETE] destroy' do
    context 'with successful response' do
      before { delete :destroy, params: valid_update_user_params }
      it { expect(response).to redirect_to users_path }
    end
  end
end
