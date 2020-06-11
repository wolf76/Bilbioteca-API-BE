# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do

  describe '#name' do
    it 'should return the title' do
      book = FactoryBot.create(:book, title: 'test_book')
      expect(book.title).to eq('test_book')
    end
  end

  describe '#book' do
    it 'should fetch all the users who own the book' do
      user = FactoryBot.create(:user)
      another_user = FactoryBot.create(:user)
      book = FactoryBot.create(:book)
      book.users << [user, another_user]

      expect(book.users.count).to eq(2)
    end
  end
end
