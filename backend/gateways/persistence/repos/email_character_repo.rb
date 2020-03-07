# frozen_string_literal: true

module Persistence
  module Repos
    class EmailCharacterRepo < ROM::Repository[:email_characters]
      include Import['persistence.container']

      commands :create,
        use: :timestamps,
        plugins_options: { timestamps: { timestamps: %i(created_at updated_at) } }

      commands update: :by_pk, 
        use: :timestamps,
        plugins_options: { timestamps: { timestamps: %i(updated_at) } }

      def upsert(attributes)
        record = email_characters.where(character: attributes[:character]).first
        record ? update(record.id, attributes) : create(attributes)
      end

      def all
        email_characters.order { count.desc }.to_a
      end
    end
  end
end
