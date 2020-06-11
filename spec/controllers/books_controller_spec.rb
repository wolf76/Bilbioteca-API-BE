require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  before(:all) do
    @user, @another_user, @third_user = FactoryBot.create_list(:user, 3)
    @book = FactoryBot.create(:book_with_users, users: [@user, @another_user])
    @another_book = FactoryBot.create(:book_with_users, users: [@another_user])
    @third_book = FactoryBot.create(:book_with_users, users: [@third_user])
    @group = FactoryBot.create(:group_with_users, created_by: @user, users: [@user, @third_user])
  end
  before(:each) do
    allow(controller).to receive(:current_user).and_return(@another_user)
  end

  context '#index' do
    it 'should fetch all books of current_user and books from groups of current_user' do
      get :index
      expect(response).to have_http_status(:ok)
      response_data = JSON.parse(response.body)
      expect(response_data.first['title']).to eq(@book.title)
      expect(response_data.second['title']).to eq(@another_book.title)
      expect(response_data.count).to eq(2)
    end

  end

  context '#create' do
    it 'should create new book' do
      params = { book: { title: 'New Book' } }
      expect{ post :create, params: params }.to change{ Book.count }.by(1)
    end

    it 'newly created book should be associated with the current_user' do
      params = { book: { title: 'Another Book' } }
      post :create, params: params
      expect(Book.last.users[0]).to eq(@another_user)
    end
  end

  context '#show' do
    it 'should fetch the book' do
      params = { id: @book.id }
      get :show, params: params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['title']).to eq(@book.title)
    end

    it 'should not fetch the book if not permitted' do
      params = { id: @third_book.id }
      get :show, params: params
      expect(response).to have_http_status(403)
    end

    it 'should fetch the book if book is present in users group' do
      params = { id: @third_book.id }
      allow(controller).to receive(:current_user).and_return(@user)
      get :show, params: params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['title']).to eq(@third_book.title)
    end
  end

  context '#update' do
    it 'should update the existing book' do
      params = { id: @book.id, book: { title: 'Title updated' } }
      put :update, params: params
      expect(response).to have_http_status(:ok)
      @book.reload
      expect(@book.title).to eq('Title updated')
    end

    it 'should update book only if it is associated to current user' do
      params = {  id: @another_book.id, book: { title: 'Title updated' }  }
      allow(controller).to receive(:current_user).and_return(@user)
      put :update, params: params
      expect(response).to have_http_status(403)
    end
  end

  context '#destroy' do
    it 'should destroy the book' do
      book_count = Book.count
      params = { id: @another_book.id }
      delete :destroy, params: params
      expect(response).to have_http_status(:ok)
      expect(Book.count).to eq(book_count - 1)
    end

    it 'should destroy book only if it is associated to current user' do
      params = {  id: @another_book.id, book: { title: 'Title updated' }  }
      allow(controller).to receive(:current_user).and_return(@user)
      delete :destroy, params: params
      expect(response).to have_http_status(403)
    end
  end

  context '#users' do
    it 'should fetch users associated to the book' do
      params = { id: @book.id }
      get :users, params: params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq(@book.users.count)
    end

    it 'should fetch users list only if current_user is associated with current book' do
      params = {  id: @another_book.id, book: { title: 'Title updated' }  }
      allow(controller).to receive(:current_user).and_return(@user)
      get :users, params: params
      expect(response).to have_http_status(403)
    end
  end

end
