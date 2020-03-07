# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :email_characters do
      primary_key :id
      column :character, String, size: 1, unique: true, null: false
      column :count, Integer, default: 0, index: true, null: false
      column :created_at, 'timestamp with time zone', null: false
      column :updated_at, 'timestamp with time zone', null: false
    end
  end
end
