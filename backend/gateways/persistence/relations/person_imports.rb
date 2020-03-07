# frozen_string_literal: true

module Persistence
  module Relations
    class PersonImports < ROM::Relation[:sql]
      schema(:person_imports, infer: true)
    end
  end
end
