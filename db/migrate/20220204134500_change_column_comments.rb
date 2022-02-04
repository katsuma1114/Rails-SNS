class ChangeColumnComments < ActiveRecord::Migration[6.0]
  def change
    change_column :comments, :content, :text, null: false
  end
end
