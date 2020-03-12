# frozen_string_literal: true

module Persistence
  module Repos
    class PersonDuplicateRepo < ROM::Repository[:person_duplicates]
      include Import['persistence.container']

      commands :create,
        use: :timestamps,
        plugins_options: { timestamps: { timestamps: %i(created_at) } }

      def all
        person_duplicates.combine(:person).combine(:duplicate).to_a
      end

      def clear
        person_duplicates.delete
      end
    end
  end
end
