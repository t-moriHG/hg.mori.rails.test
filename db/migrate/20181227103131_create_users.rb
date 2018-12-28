class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name,              limit: 255,   null: false
      t.string :password_digest,   limit: 255,   null: false
      t.string :remember_token,    limit: 255
      t.boolean :delete_flag,      limit: 255,   default: false
      t.datetime :created_at,                    null: false
      t.datetime :updated_at,                    null: false
    end
  end
end
