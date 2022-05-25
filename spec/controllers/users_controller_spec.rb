# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create :user }
  let(:valid_update_user_params) do
    { id: user.id, user: { name: 'Name', surname: 'Surname' } }
  end
  let(:valid_user_params) do
    { user: { name: 'Kup', surname: 'Jerevan' } }
  end
  let(:invalid_user_params) do
    { user: { name: nil, surname: 'Surname' } }
  end
  let(:invalid_update_user_params) do
    { id: user.id, user: { name: nil, surname: 'surname' } }
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
    context 'with successful response' do
      let(:create_user) { post :create, params: valid_user_params }
      it { expect(User.last.name).to eql(valid_user_params[:user][:name]) }
      it { expect(User.last.surname).to eql(valid_user_params[:user][:surname]) }
      it { expect(create_user).to redirect_to user_path(id: User.last.id) }
      it { expect { create_user }.to change(User, :count).by(1) }
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
      it { expect(User.last.name).to eql(valid_update_user_params[:user][:name]) }
      it { expect(User.last.surname).to eql(valid_update_user_params[:user][:surname]) }
    end

    context 'with error' do
      before { put :update, params: invalid_update_user_params }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe '[DELETE] destroy' do
    context 'with successful response' do
      let(:delete_user) { delete :destroy, params: { id: user.id } }
      it { expect { delete_user }.to change(User, :count).by(-1) }
      it { expect(delete_user).to redirect_to users_path }
    end
  end
end
