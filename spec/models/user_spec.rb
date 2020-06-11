# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#name' do
    it 'should return the name' do
      user = FactoryBot.create(:user, name: 'tester')
      expect(user.name).to eq('tester')
    end
  end

  describe '#groups' do
    it 'should fetch all the groups in which the current user exists' do
      user = FactoryBot.create(:user)
      group = FactoryBot.create(:group)
      another_group = FactoryBot.create(:group)
      user.groups << [group, another_group]

      expect(user.groups.count).to eq(2)
    end
  end

  describe '#books' do
    it 'should fetch all the books of the user' do
      user = FactoryBot.create(:user)
      book = FactoryBot.create(:book)
      another_book = FactoryBot.create(:book)
      user.books << [book, another_book]

      expect(user.books.count).to eq(2)
    end
  end
end
