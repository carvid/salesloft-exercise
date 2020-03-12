RSpec.describe Persistence::Repos::PersonDuplicateRepo do
  let :attributes do
    {
      id: 1,
      person_id: person.id,
      duplicate_id: duplicate.id,
      created_at: Time.now,
    }
  end

  let :person do
    person_repo.create(
      id: 1,
      first_name: 'Michael',
      last_name: 'Scott',
      email_address: 'mscott@dunder-mifflin.com',
      title: 'Regional Manager',
      created_at: Time.now,
      updated_at: Time.now,
    )
  end

  let :duplicate do
    person_repo.create(
      id: 2,
      first_name: 'Michael',
      last_name: 'Scott',
      email_address: 'mcott@dunder-mifflin.com',
      title: 'Regional Manager',
      created_at: Time.now,
      updated_at: Time.now,
    )
  end

  let :person_repo do
    Persistence::Repos::PersonRepo.new
  end

  describe '#create' do
    it 'creates a person duplicate' do
      new = subject.create(attributes)
      expect(new.id).to eq(attributes[:id])
      expect(new.person_id).to eq(attributes[:person_id])
      expect(new.duplicate_id).to eq(attributes[:duplicate_id])
      expect(new.created_at).to eq(attributes[:created_at])
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
  end

  describe '#all' do
    let!(:duplicate_1) { subject.create(attributes.merge(id: 1)) }
    let!(:duplicate_2) { subject.create(attributes.merge(id: 2)) }

    it 'returns all records' do
      found = subject.all
      expect(found.map(&:id)).to include(duplicate_1.id, duplicate_2.id)
    end
  end

  describe '#clear' do
    let!(:duplicate_1) { subject.create(attributes.merge(id: 1)) }
    let!(:duplicate_2) { subject.create(attributes.merge(id: 2)) }

    it 'deletes all records' do
      subject.clear
      expect(subject.all).to be_empty
    end
  end
end

