# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :people do
      primary_key :id
      column :first_name, String
      column :last_name, String
      column :email_address, String
      column :title, String

      column :created_at, 'timestamp with time zone', null: false
      column :updated_at, 'timestamp with time zone', null: false
    end
  end
end
