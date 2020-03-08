# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Operations::CountEmailCharacters do
  include Dry::Monads[:result]

  subject do
    described_class.new(
      person_repo: person_repo,
      email_character_repo: email_character_repo,
      retrieve_people: retrieve_people,
    )
  end

  let :person_repo do 
    repo = double('PersonRepo')
    allow(repo).to receive(:create).and_return(*people)
    repo
  end

  let :email_character_repo do 
    repo = double('EmailCharacters')
    allow(repo).to receive(:upsert).and_return(*characters)
    repo
  end

  let :retrieve_people do
    -> { Success(people) }
  end

  let :people_attrs do
    [
      {
        id: 1,
        first_name: 'Michael',
        last_name: 'Scott',
        email_address: 'mscott@dunder-mifflin.com',
        title: 'Regional Manager',
        created_at: Time.now,
        updated_at: Time.now,
      },
      {
        id: 2,
        first_name: 'Dwight',
        last_name: 'Schrute',
        email_address: 'dschrute@dunder-mifflin.com',
        title: 'Assistant Regional Manager',
        created_at: Time.now,
        updated_at: Time.now,
      }
    ]
  end

  let :people do
    people_attrs.map { |attrs| OpenStruct.new(attrs) }
  end

  let :characters_attrs do
    [
      { character: 'm', count: 5 },
      { character: 's', count: 2 },
      { character: 'c', count: 4 },
      { character: 'o', count: 3 },
      { character: 't', count: 3 },
      { character: 'd', count: 5 },
      { character: 'u', count: 3 },
      { character: 'n', count: 4 },
      { character: 'e', count: 3 },
      { character: 'r', count: 3 },
      { character: 'i', count: 4 },
      { character: 'f', count: 4 },
      { character: 'l', count: 2 },
      { character: 'h', count: 1 },
    ]
  end

  let :characters do
    characters_attrs.map { |attrs| OpenStruct.new(attrs) }
  end

  it 'returns a successful output' do
    output = subject.call
    expect(output).to be_success
  end

  it 'retrieve people from the database' do
    expect(retrieve_people).to receive(:call).and_return(Success(people))
    subject.call
  end

  it 'persists email characters in the database' do
    expect(email_character_repo).to receive(:upsert).and_return(characters)
    subject.call
  end

  it 'returns the character counting' do
    output = subject.call
    expect(output.value!).to eq(characters)
  end
end
