# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Operations::ImportPeople do
  subject do
    described_class.new(
      poller: poller,
      person_repo: person_repo,
      person_import_repo: person_import_repo,
    )
  end

  let :poller do
    poller = double('Poller')
    allow(poller).to receive(:fetch_people).and_return(people_attrs)
    poller
  end

  let :person_repo do 
    repo = double('PersonRepo')
    allow(repo).to receive(:create).and_return(*people)
    repo
  end

  let :person_import_repo do 
    repo = double('PersonImportRepo')
    allow(repo).to receive(:create).and_return(last_import)
    allow(repo).to receive(:last).and_return(last_import)
    repo
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

  let :last_import_attrs do
    { cursor: Time.now, created_at: Time.now }
  end

  let :last_import do
    OpenStruct.new(last_import_attrs)
  end

  it 'returns a successful output' do
    output = subject.call
    expect(output).to be_success
  end

  it 'gets the cursor time of the last import from the database' do
    expect(person_import_repo).to receive(:last).and_return(last_import)
    subject.call
  end

  it 'fetches people records from an external source (Salesloft API)' do
    expect(poller).to receive(:fetch_people).with(last_import.cursor).and_return(people_attrs)
    subject.call
  end

  it 'persists people in the database' do
    expect(person_repo).to receive(:create).and_return(people)
    subject.call
  end

  it 'persists a new cursor time in the database' do
    expect(person_import_repo).to receive(:create).with(cursor: people.last.updated_at).and_return(last_import)
    subject.call
  end
end
