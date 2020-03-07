# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Operations::RetrievePeople do
  let :person_repo do 
    repo = double('PersonRepo')
    allow(repo).to receive(:all).and_return(people)
    repo
  end

  let :people do
    [
      { first_name: 'Michael', last_name: 'Scott', email_address: 'mscott@dunder-mifflin.com' },
      { first_name: 'Dwight', last_name: 'Schrute', email_address: 'dschrute@dunder-mifflin.com' },
    ]
  end

  subject { described_class.new(person_repo: person_repo) }

  it 'fetch all people from the database' do
    expect(person_repo).to receive(:all)
    subject.call
  end

  it 'returns a successful output' do
    output = subject.call
    expect(output).to be_success
  end

  it 'returns all existent people' do
    output = subject.call
    expect(output.value!).to eq(people)
  end
end
