# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module Operations
  class RetrievePeople
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    include Import[
      'persistence.repos.person_repo',
    ]

    def call
      people = yield retrieve_people
      Success(people)
    end

    def retrieve_people
      people = person_repo.all
      Success(people)
    end
  end
end
