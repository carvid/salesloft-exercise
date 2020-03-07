# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module Operations
  class RetrieveEmailCharacters
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    include Import['persistence.repos.email_character_repo']

    def call
      Success(email_character_repo.all)
    end
  end
end
