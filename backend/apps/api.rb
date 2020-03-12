# frozen_string_literal: true

require_relative '../system/boot'

require 'roda'
require 'json'

class Api < Roda
  include Import[
    'operations.retrieve_people',
    'operations.retrieve_email_characters',
    'operations.retrieve_duplicated_people',
  ]

  plugin :all_verbs
  plugin :default_headers,
    'Content-Type' => 'application/json',
    'Access-Control-Allow-Origin' => '*'

  # Routes

  route do |r|
    r.on 'people' do
      r.is do
        r.get do
          json(retrieve_people.call)
        end
      end

      r.on 'email_characters' do
        r.is do
          r.get do
            json(retrieve_email_characters.call)
          end
        end
      end

      r.on 'duplicates' do
        r.is do
          r.get do
            json(retrieve_duplicated_people.call)
          end
        end
      end
    end
  end

  # Helpers

  def json(output)
    if output.success?
      output.success.map(&:to_h).to_json
    end
  end
end
