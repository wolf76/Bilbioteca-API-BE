require 'rails_helper'

RSpec.describe 'sign_in/sign_out', type: :request do
  let(:user) { FactoryBot.create(:user)}
  let(:url) { '/auth/sign_in' }
  let(:params) do
    {
      email: user.email,
      password: user.password
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns access token in authorization header' do
      expect(response.headers['access-token']).to be_present
      expect(response.headers['client']).to be_present
      expect(response.headers['uid']).to eq(user.email)
    end
  end

  context 'when login params are incorrect' do
    before { post url }

    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end

  context 'signing out' do
    it 'returns 204, no content' do
      post url, params: params
      sign_out_params = {
        'access-token': response.headers['access-token'],
        'client': response.headers['client'],
        'uid': response.headers['uid']
      }
      delete '/auth/sign_out', params: sign_out_params
      expect(response).to have_http_status(200)
    end
  end

end

RSpec.describe 'sign_up', type: :request do
  let(:user) { FactoryBot.create(:user)}
  let(:url) { '/auth/' }
  let(:params) do
    {
      "name": "test",
      "email": "test@gmail.com",
      "password": "123456"
    }
  end

  context 'registration' do
    it 'should register a new user' do
      total_user_count = User.count
      post url, params: params
      expect(response).to have_http_status(200)
      expect(User.count).to eq(total_user_count + 1)
    end
  end

end
