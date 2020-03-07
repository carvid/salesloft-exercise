require 'spec_helper'

RSpec.describe Persistence::Repos::PersonImportRepo do
  let :attributes do
    {
      id: 1,
      cursor: Time.now,
      created_at: Time.now,
    }
  end

  describe '#create' do
    it 'creates a person import' do
      new = subject.create(attributes)
      expect(new.id).to eq(attributes[:id])
      expect(new.cursor).to eq(attributes[:cursor])
      expect(new.created_at).to eq(attributes[:created_at])
    end

    it 'assigns a new id if not given' do
      new = subject.create(attributes)
      expect(new.id).not_to be_nil
    end

    it 'assigns a new created_at time if not given' do
      new = subject.create(attributes)
      expect(new.created_at).not_to be_nil
    end
  end

  describe '#last' do
    let!(:last) { subject.create(cursor: Time.now - 1) }
    let!(:first) { subject.create(cursor: Time.now - 10) }

    it 'returns the record with most recent cursor time' do
      found = subject.last
      expect(found).to eq(last)
    end
  end
end

