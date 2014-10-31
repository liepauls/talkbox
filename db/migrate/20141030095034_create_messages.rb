class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user
      t.belongs_to :room
      t.string :text

      t.timestamps
    end
  end
end
