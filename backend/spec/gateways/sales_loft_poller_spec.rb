require 'spec_helper'

RSpec.describe Polling::SalesLoftPoller, external: true do
  subject { Polling::SalesLoftPoller.new(ENV['SALES_LOFT_API_KEY']) }

  describe '#fetch_people' do
    context 'successful call' do
      before do
        @people = subject.fetch_people
      end

      it 'returns an array' do
        expect(@people).to be_an_instance_of(Array)
      end

      it 'returns a array with elements' do
        expect(@people).not_to be_empty
      end

      it 'returns person hash elements' do
        @people.each do |person|
          expect(person).to be_an_instance_of(Hash)
          expect(person[:first_name]).to_not be_nil
          expect(person[:last_name]).to_not be_nil
          expect(person[:email_address]).to_not be_nil
        end
      end
    end

    context 'unsuccessful call' do
      subject { Polling::SalesLoftPoller.new('invalid_api_key') }

      it 'raise an error' do
        expect { subject.fetch_people }.to raise_error(RestClient::Unauthorized)
      end
    end
  end
end
