# frozen_string_literal: true

module Persistence
  module Relations
    class EmailCharacters < ROM::Relation[:sql]
      schema(:email_characters, infer: true)
    end
  end
end
