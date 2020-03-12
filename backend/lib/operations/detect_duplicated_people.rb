# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'damerau-levenshtein'

module Operations
  class DetectDuplicatedPeople
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    include Import[
      'persistence.repos.person_duplicate_repo',
      'operations.retrieve_people',
    ]

    def call
      clear_duplicates
      people = yield retrieve_people.call
      duplicated = yield detect_posible_duplicates(people)
      Success(duplicated)
    end

    def clear_duplicates
      person_duplicate_repo.clear
    end

    def detect_posible_duplicates(people)
      duplicates = []
      people.map.with_index do |person, i|
        (i + 1).upto(people.size - 1) do |j|
          if same_person?(person, people[j])
            duplicates << create_duplicate(person, people[j])
          end
        end
      end
      Success(duplicates)
    end

    def create_duplicate(person, duplicate)
      person_duplicate_repo.create(person_id: person.id, duplicate_id: duplicate.id)
    end

    def same_person?(person_1, person_2)
      distance = DamerauLevenshtein.distance(person_1.email_address, person_2.email_address)
      distance <= 1
    end
  end
end
