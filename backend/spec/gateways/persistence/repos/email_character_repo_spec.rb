require 'spec_helper'

RSpec.describe Persistence::Repos::EmailCharacterRepo do
  let :attributes do
    {
      id: 1,
      character: 'a',
      count: 1,
      created_at: Time.now,
      updated_at: Time.now,
    }
  end

  describe '#create' do
    it 'creates a person import' do
      new = subject.create(attributes)
      expect(new.id).to eq(attributes[:id])
      expect(new.character).to eq(attributes[:character])
      expect(new.count).to eq(attributes[:count])
      expect(new.created_at).to eq(attributes[:created_at])
      expect(new.updated_at).to eq(attributes[:updated_at])
    end

    it 'assigns a new id if not given' do
      attributes.delete(:id)
      new = subject.create(attributes)
      expect(new.id).not_to be_nil
    end

    it 'assigns a new created_at time if not given' do
      attributes.delete(:created_at)
      new = subject.create(attributes)
      expect(new.created_at).not_to be_nil
    end

    it 'assigns a new updated_at time if not given' do
      attributes.delete(:updated_at)
      new = subject.create(attributes)
      expect(new.updated_at).not_to be_nil
    end
  end

  describe '#update' do
    let(:count) { 2 }
    let(:email_character) { subject.create(attributes) }

    it 'updates given attributes' do
      updated = subject.update(email_character.id, count: count)
      expect(updated.count).to eq(count)
    end

    it 'automatically updates updated_at attribute' do
      updated = subject.update(email_character.id, count: count)
      expect(updated.updated_at).to be > email_character.updated_at
    end

    it 'does not update not given attributes' do
      updated = subject.update(email_character.id, count: count)
      expect(updated.character).to eq(email_character.character)
      expect(updated.created_at).to eq(email_character.created_at)
    end
  end

  describe '#all' do
    let!(:frequent) { subject.create(character: 'a', count: 100) }
    let!(:infrequent) { subject.create(character: 'b', count: 1) }

    it 'returns all records' do
      found = subject.all
      expect(found).to include(frequent, infrequent)
    end

    it 'returns records order by count value' do
      found = subject.all
      expect(found.first).to eq(frequent)
    end
  end
end
