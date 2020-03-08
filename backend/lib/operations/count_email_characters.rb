# frozen_string_literal: true

require 'set'
require 'dry/monads'
require 'dry/monads/do'

module Operations
  class CountEmailCharacters
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    include Import[
      'persistence.repos.person_repo',
      'persistence.repos.email_character_repo',
      'operations.retrieve_people',
    ]

    CHARS = Set.new('a'..'z')

    def call
      people = yield retrieve_people.call
      characters = yield count_characters(people)
      characters = yield persist_characters(characters)
      Success(characters)
    end

    def count_characters(people)
      characters = people.each_with_object(Hash.new(0)) do |person, chars|
        email = person.email_address.downcase
        email.each_char { |char| chars[char] += 1 if CHARS.include?(char) }
      end
      Success(characters)
    end

    def persist_characters(characters)
      Success(characters.map do|character, count|
        email_character_repo.upsert(character: character, count: count)
      end)
    end
  end
end

