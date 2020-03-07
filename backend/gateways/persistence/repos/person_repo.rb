# frozen_string_literal: true

module Persistence
  module Repos
    class PersonRepo < ROM::Repository[:people]
      include Import['persistence.container']

      commands :create, update: :by_pk

      def all
        people.to_a
      end
    end
  end
end
