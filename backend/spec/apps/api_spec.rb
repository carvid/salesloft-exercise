# frozen_string_literal: true

require 'spec_helper'

require 'rack/test'
require_relative '../../apps/api'

RSpec.describe Api do
  include Rack::Test::Methods

  let(:app) { Api }

  describe 'GET /people' do
    include Import['persistence.repos.person_repo']

    def do_request
      get '/people'
    end

    let! :person do
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

    it 'responds with application/json content-type' do
      do_request
      expect(last_response.content_type).to eq 'application/json'
    end

    it 'responds with 200 code' do
      do_request
      expect(last_response).to be_ok
    end

    it 'returns a success body response' do
      do_request
      body = JSON.parse(last_response.body, symbolize_names: true)

      expect(body).to all(match({
        id: an_instance_of(Integer),
        first_name: an_instance_of(String),
        last_name: an_instance_of(String),
        email_address: an_instance_of(String),
        title: an_instance_of(String),
        created_at: an_instance_of(String),
        updated_at: an_instance_of(String),
      }))
    end
  end

  describe 'GET /people/email_characters' do
    include Import['persistence.repos.email_character_repo']

    def do_request
      get '/people/email_characters'
    end

    let! :email_character do
      email_character_repo.create(
        character: 'a',
        count: '1',
      )
    end

    it 'responds with application/json content-type' do
      do_request
      expect(last_response.content_type).to eq 'application/json'
    end

    it 'responds with 200 code' do
      do_request
      expect(last_response).to be_ok
    end

    it 'returns a success body response' do
      do_request
      body = JSON.parse(last_response.body, symbolize_names: true)

      expect(body).to all(match({
        id: an_instance_of(Integer),
        character: an_instance_of(String),
        count: an_instance_of(Integer),
        created_at: an_instance_of(String),
        updated_at: an_instance_of(String),
      }))
    end
  end
end
