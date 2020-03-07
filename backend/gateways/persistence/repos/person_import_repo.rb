# frozen_string_literal: true

module Persistence
  module Repos
    class PersonImportRepo < ROM::Repository[:person_imports]
      include Import['persistence.container']

      commands :create,
        use: :timestamps,
        plugins_options: { timestamps: { timestamps: %i(created_at) } }

      def last
        person_imports.order { cursor.desc }.first
      end
    end
  end
end
