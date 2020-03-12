# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Operations::RetrieveDuplicatedPeople do
  let :person_duplicate_repo do
    repo = double('PersonDuplicateRepo')
    allow(repo).to receive(:all).and_return(duplicates)
    repo
  end

  let :duplicates do
    [
      { id: 1, person_id: 1, duplicate_id: 2, created_at: Time.now },
    ]
  end

  subject { described_class.new(person_duplicate_repo: person_duplicate_repo) }

  it 'fetch all duplicates from the database' do
    expect(person_duplicate_repo).to receive(:all)
    subject.call
  end

  it 'returns a successful output' do
    output = subject.call
    expect(output).to be_success
  end

  it 'returns all existent duplicates' do
    output = subject.call
    expect(output.value!).to eq(duplicates)
  end
end
