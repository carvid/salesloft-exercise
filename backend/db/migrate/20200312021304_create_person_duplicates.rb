# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :person_duplicates do
      primary_key :id
      foreign_key :person_id, :people, index: true, null: false
      foreign_key :duplicate_id, :people, index: true, null: false
      column :created_at, 'timestamp with time zone', null: false
    end
  end
end
