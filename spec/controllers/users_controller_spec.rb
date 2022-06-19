# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }
  let!(:admin) do
    create :user
  end
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
    context 'as admin' do
      before do
        sign_in admin
        get :index
      end

      it do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response).to render_template(:index)
      end
    end

    context 'as not logged in user' do
      before { get :index }

      it do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response).to render_template(:index)
      end
    end

    context 'as user' do
      before do
        sign_in user
        get :index
      end

      it do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response).to render_template(:index)
      end
    end
  end
  describe '[GET] #show' do
    context 'as admin' do
      before do
        sign_in admin
        get :show, params: { id: user.id }
      end
      it do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response).to render_template(:show)
      end
    end

    context 'as user' do
      before do
        sign_in user
        get :show, params: { id: user.id }
      end
      it do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response).to render_template(:show)
      end
    end

    context 'as not logged in user' do
      before { get :show, params: { id: user.id } }
      it do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response).to render_template(:show)
      end
    end
  end

  # describe '[POST] #create' do
  #   context 'with successful response' do
  #     let(:create_user) { post :create, params: valid_user_params }
  #     it do
  #       expect(create_user).to redirect_to user_path(id: User.last.id)
  #       expect(User.last.name).to eq(valid_user_params.dig(:user, :name))
  #       expect(User.last.surname).to eq(valid_user_params.dig(:user, :surname))
  #     end
  #     it { expect { create_user }.to change(User, :count).by(1) }
  #   end
  #   context 'with error' do
  #     before { post :create, params: invalid_user_params }
  #
  #     it { expect(response).to render_template(:new) }
  #   end
  # end

  # describe '[PATCH/PUT] #update' do
  #
  #   context 'as admin' do
  #     before do
  #       sign_in admin
  #       put :update, params: valid_update_user_params
  #     end
  #     it { expect(response).to redirect_to user_path(id: user.id) }
  #     it { expect(User.find(id: user.id).name).to eq(valid_update_user_params.dig(:user, :name)) }
  #     it { expect(User.find(id: user.id).surname).to eq(valid_update_user_params.dig(:user, :surname)) }
  #   end

    context 'as user' do
      before do
        sign_in user
        put :update, params: { id: user.id }
      end
      it { expect(response).to redirect_to users_path }
    end

    context 'as not logged in user' do
      before { put :update, params: valid_update_user_params }
      it { expect(response).to redirect_to new_user_session_path }
    end

  #   context 'with error' do
  #     before do
  #       sign_in admin
  #       put :update, params: invalid_update_user_params
  #     end
  #     it { expect(response).to render_template(:edit) }
  #   end
  #
  # end
  #
  # describe '[DELETE] destroy' do
  #   context 'with successful response' do
  #     let(:delete_user) { delete :destroy, params: { id: user.id } }
  #     it { expect { delete_user }.to change(User, :count).by(-1) }
  #     it { expect(delete_user).to redirect_to users_path }
  #   end
  # end

end
