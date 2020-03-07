require 'spec_helper'

RSpec.describe Persistence::Repos::PersonRepo do
  let :person_1 do
    {
      id: 1,
      first_name: 'Michael',
      last_name: 'Scott',
      email_address: 'mscott@dunder-mifflin.com',
      title: 'Regional Manager',
      created_at: Time.now,
      updated_at: Time.now,
    }
  end

  let :person_2 do
    {
      id: 2,
      first_name: 'Dwight',
      last_name: 'Schrute',
      email_address: 'dschrute@dunder-mifflin.com',
      title: 'Assistant Regional Manager',
      created_at: Time.now,
      updated_at: Time.now,
    }
  end

  describe '#create' do
    it 'creates a person' do
      person = subject.create(person_1)
      expect(person.id).to eq(person_1[:id])
      expect(person.first_name).to eq(person_1[:first_name])
      expect(person.last_name).to eq(person_1[:last_name])
      expect(person.email_address).to eq(person_1[:email_address])
      expect(person.title).to eq(person_1[:title])
      expect(person.created_at).to eq(person_1[:created_at])
      expect(person.updated_at).to eq(person_1[:updated_at])
    end
  end

  describe '#update' do
    let(:title) { 'Engineer' }
    let(:person) { subject.create(person_1) }

    it 'updates given attributes' do
      updated = subject.update(person.id, title: title)
      expect(updated.title).to eq(title)
    end

    it 'does not update not given attributes' do
      updated = subject.update(person.id, title: title)
      expect(updated.first_name).to eq(person.first_name)
      expect(updated.last_name).to eq(person.last_name)
      expect(updated.email_address).to eq(person.email_address)
      expect(updated.created_at).to eq(person.created_at)
      expect(updated.updated_at).to eq(person.updated_at)
    end
  end

  describe '#all' do
    before do
      subject.create(person_1)
      subject.create(person_2)
    end

    it 'returns all people' do
      people = subject.all.map(&:to_h)
      expect(people).to include(person_1, person_2) 
    end
  end
end
