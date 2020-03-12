# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module Operations
  class RetrieveDuplicatedPeople
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    include Import[
      'persistence.repos.person_duplicate_repo',
    ]

    def call
      duplicates = yield retrieve_duplicated_people
      Success(duplicates)
    end

    def retrieve_duplicated_people
      duplicates = person_duplicate_repo.all
      Success(duplicates)
    end
  end
end
