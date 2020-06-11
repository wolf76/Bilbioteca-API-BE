# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do

  describe '#attributes' do
    it 'should return the name' do
      group = FactoryBot.create(:group, name: 'test_group')
      expect(group.name).to eq('test_group')
    end
  end

  describe '#group' do
    it 'should fetch all the users in current group' do
      user = FactoryBot.create(:user)
      another_user = FactoryBot.create(:user)
      group = FactoryBot.create(:group)
      group.users << [user, another_user]

      expect(group.users.count).to eq(2)
    end
  end
end
