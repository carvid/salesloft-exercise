# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Operations::DetectDuplicatedPeople do
  include Dry::Monads[:result]

  subject do
    described_class.new(
      person_duplicate_repo: person_duplicate_repo,
      retrieve_people: retrieve_people,
    )
  end

  let :person_duplicate_repo do
    repo = double('PersonDuplicateRepo')
    allow(repo).to receive(:clear).and_return([])
    allow(repo).to receive(:create).and_return(*duplicates)
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
        first_name: 'Michael',
        last_name: 'Scott',
        email_address: 'mcott@dunder-mifflin.com',
        title: 'Regional Manager',
        created_at: Time.now,
        updated_at: Time.now,
      }
    ]
  end

  let :people do
    people_attrs.map { |attrs| OpenStruct.new(attrs) }
  end

  let :duplicates_attrs do
    [
      { id: 1, person_id: 1, duplicate_id: 2, create_at: Time.now },
    ]
  end

  let :duplicates do
    duplicates_attrs.map { |attrs| OpenStruct.new(attrs) }
  end

  it 'returns a successful output' do
    output = subject.call
    expect(output).to be_success
  end

  it 'deletes all records from the database' do
    expect(person_duplicate_repo).to receive(:clear).and_return([])
    subject.call
  end

  it 'persists duplicated people in the database' do
    expect(person_duplicate_repo).to receive(:create).and_return(duplicates)
    subject.call
  end

  it 'returns detected duplicated people' do
    output = subject.call
    expect(output.value!).to eq(duplicates)
  end
end

