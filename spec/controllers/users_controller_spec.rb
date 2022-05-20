# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '[GET] #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
    it 'returns a 200 response' do
      get :index
      expect(response).to have_http_status '200'
    end
  end

  describe '[GET] #show' do
    before do
      @user = FactoryBot.create(:user)
      get :show, params: { id: @user.id }
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end
  end


  # Expected response to be a redirect to <http://test.host/users/3> but was a redirect to <http://test.host/users/4>.
  describe '[POST] #create' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'responds successfully' do
      post(:create, params: { user: FactoryBot.attributes_for(:user) })
      expect(response).to redirect_to user_path(@user.id)
    end
  end
end

describe '[PATH] #update' do
=begin
  before do
    @user = FactoryBot.create(:user)
  end
  it 'user successfully update' do
    patch(:update, params: { user: { name: 'Name', surname: 'ERE' } })
    expect(@user.reload.name).to eq 'Name'
  end
=end
end

describe '[DELETE] destroy' do
  it 'user successfully destroy'
end
