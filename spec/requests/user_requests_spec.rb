require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'GET /' do
    before :each do
      get unauthenticated_root_path
    end

    it 'returns http success' do
      expect(response).to be_successful
    end

    it 'should render splash_screen view' do
      expect(response).to render_template(:index)
    end

    it 'should render placeholder from new view' do
      expect(response.body).to include('Sign Up')
    end
  end
  context 'GET /login' do
    before :each do
      get new_user_session_path
    end

    it 'returns http success' do
      expect(response).to be_successful
    end

    it 'renders sessions/new view' do
      expect(response).to render_template(:new)
    end

    it 'renders content from the view' do
      expect(response.body).to include('Log in')
    end
  end

  context 'GET /sign_up' do
    before :each do
      get new_user_registration_path
    end

    it 'returns http success' do
      expect(response).to be_successful
    end

    it 'should render sessions/new view' do
      expect(response).to render_template(:new)
    end

    it 'should render placeholder from new view' do
      expect(response.body).to include('Sign up')
    end
  end
end
