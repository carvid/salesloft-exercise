# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Operations::RetrieveEmailCharacters do
  let :email_character_repo do 
    repo = double('EmailCharacterRepo')
    allow(repo).to receive(:all).and_return(characters)
    repo
  end

  let :characters do
    [
      { character: 'a', count: '1' },
      { character: 'b', count: '2' },
      { character: 'c', count: '3' },
    ]
  end

  subject { described_class.new(email_character_repo: email_character_repo) }

  it 'returns all existent email characters' do
    expect(email_character_repo).to receive(:all)
    subject.call
  end

  it 'returns a successful output' do
    output = subject.call
    expect(output).to be_success
  end

  it 'include all existent characters' do
    output = subject.call
    expect(output.success).to eq(characters)
  end
end
