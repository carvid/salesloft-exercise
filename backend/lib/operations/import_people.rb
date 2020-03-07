# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module Operations
  class ImportPeople
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    include Import[
      'polling.poller',
      'persistence.repos.person_repo',
      'persistence.repos.person_import_repo',
    ]

    def call
      cursor = yield retrieve_last_cursor
      people = yield fetch_people(cursor)
      people = yield persist_people(people)
      yield persist_cursor(people)
      Success(people)
    end

    def retrieve_last_cursor
      cursor = person_import_repo.last&.cursor
      Success(cursor)
    end

    def fetch_people(cursor)
      people = poller.fetch_people(cursor)
      Success(people)
    end

    def persist_people(people)
      attributes = [:id, :first_name, :last_name, :email_address, :title, :created_at, :updated_at]
      people = people.map { |person| person_repo.create(person.slice(*attributes)) }
      Success(people)
    end

    def persist_cursor(people)
      cursor = people.last&.updated_at
      person_import_repo.create(cursor: cursor) if cursor
      Success(cursor)
    end
  end
end
