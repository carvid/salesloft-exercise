# frozen_string_literal: true

require 'json'
require 'rest-client'

module Polling
  class SalesLoftPoller
    API_HOST = "https://api.salesloft.com/v2"
    PER_PAGE = 100

    def initialize(access_token)
      @access_token = access_token
    end

    def fetch_people(cursor = nil)
      url = "#{API_HOST}/people?#{params(cursor)}"
      response = RestClient.get(url, headers)
      json = JSON.parse(response.body, symbolize_names: true)
      json[:data]
    end

    private

    def headers
      {
        accept: :json,
        content_type: :json,
        authorization: "Bearer #{@access_token}",
      }
    end

    def params(cursor)
      params = []
      params << "per_page=#{PER_PAGE}"
      params << "sort=updated_at"
      params << "sort_direction=ASC"
      params << "updated_at[gt]=#{cursor.iso8601(6)}" if cursor
      params.join('&')
    end
  end
end
