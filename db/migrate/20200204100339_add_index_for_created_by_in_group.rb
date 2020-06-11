class AddIndexForCreatedByInGroup < ActiveRecord::Migration[6.0]
  def change
    change_column :groups, :created_by, :integer, using: 'created_by::integer'
    add_index :groups, :created_by
  end
end
