# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :spotify_user_id
      t.string :email
      t.boolean :expires
      t.integer :expires_at
      t.text :refresh_token
      t.text :token
      t.text :playlist_id
    end
  end
end
