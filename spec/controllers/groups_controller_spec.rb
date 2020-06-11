require 'rails_helper'

RSpec.describe GroupsController, type: :controller do

  before(:all) do
    @user, @another_user = FactoryBot.create_list(:user, 2)
    @book = FactoryBot.create(:book_with_users, users: [@user])
    @another_book = FactoryBot.create(:book_with_users, users: [@another_user])
    @group = FactoryBot.create(:group_with_users, created_by: @user, users: [@user, @another_user])
    @another_group = FactoryBot.create(:group, created_by: @another_user)
  end
  before(:each) do
    allow(controller).to receive(:current_user).and_return(@user)
  end

  context '#index' do
    it 'should fetch all groups of user' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq(1)
      expect(JSON.parse(response.body)[0]['name']).to eq(@group.name)
    end

  end

  context '#create' do
    it 'should create new group' do
      params = { group: { name: 'New Group' } }
      expect{ post :create, params: params }.to change{ Group.count }.by(1)
    end

    it 'newly created group should be associated with the current_user' do
      params = { group: { name: 'Another group' } }
      post :create, params: params
      expect(Group.last.users[0]).to eq(@user)
    end
  end

  context '#show' do
    it 'should fetch the group' do
      params = { id: @group.id }
      get :show, params: params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq(@group.name)
    end

    it 'should not fetch the group if user is not associated with it' do
      params = { id: @another_group.id }
      get :show, params: params
      expect(response).to have_http_status(403)
    end
  end

  context '#update' do
    it 'should update the existing group' do
      params = { id: @group.id, group: { name: 'Updated name' } }
      put :update, params: params
      expect(response).to have_http_status(:ok)
      expect(@group.reload.name).to eq('Updated name')
    end

    it 'should update only if group is created by same user' do
      params = { id: @group.id, group: { name: 'Updated name' } }
      allow(controller).to receive(:current_user).and_return(@another_user)
      put :update, params: params
      expect(response).to have_http_status(403)
    end
  end

  context '#destroy' do
    it 'should destroy the group' do
      group_count = Group.count
      params = { id: @another_group.id }
      allow(controller).to receive(:current_user).and_return(@another_user)
      delete :destroy, params: params
      expect(response).to have_http_status(:ok)
      expect(Group.count).to eq(group_count - 1)
    end

    it 'should destroy the group only if created by same user' do
      params = { id: @group.id }
      allow(controller).to receive(:current_user).and_return(@another_user)
      delete :update, params: params
      expect(response).to have_http_status(403)
    end
  end

  context '#users' do
    it 'should fetch users in the group' do
      params = { id: @group.id }
      get :users, params: params
      expect(response).to have_http_status(:ok)
      @group.reload
      expect(JSON.parse(response.body).count).to eq(@group.users.count)
    end

    it 'should throw error if user is not in the group' do
      params = { id: @another_group.id }
      allow(controller).to receive(:current_user).and_return(@another_user)
      get :users, params: params
      expect(response).to have_http_status(403)
    end
  end

  context '#books' do
    it 'should fetch all the books of every user in the group' do
      params = { id: @group.id }
      get :books, params: params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq(@group.books.count)
    end

    it 'should throw error if current_user is not in the group' do
      params = { id: @another_group.id }
      allow(controller).to receive(:current_user).and_return(@another_user)
      get :books, params: params
      expect(response).to have_http_status(403)
    end
  end

end
