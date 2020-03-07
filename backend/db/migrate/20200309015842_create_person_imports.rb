# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :person_imports do
      primary_key :id
      column :cursor, 'timestamp with time zone', index: true, null: false
      column :created_at, 'timestamp with time zone', null: false
    end
  end
end
