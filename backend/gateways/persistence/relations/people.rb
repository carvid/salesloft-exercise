# frozen_string_literal: true

module Persistence
  module Relations
    class People < ROM::Relation[:sql]
      schema(:people, infer: true)
    end
  end
end
