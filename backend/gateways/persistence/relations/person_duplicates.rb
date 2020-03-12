# frozen_string_literal: true

module Persistence
  module Relations
    class PersonDuplicates < ROM::Relation[:sql]
      schema(:person_duplicates, infer: true) do
        associations do
          belongs_to :people, as: :person, foreign_key: :person_id
          belongs_to :people, as: :duplicate, foreign_key: :duplicate_id
        end
      end
    end
  end
end
