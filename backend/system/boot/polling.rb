# frozen_string_literal: true

Application.boot(:polling) do
  init do
    require 'polling/sales_loft_poller'
  end

  start do
    register('polling.poller', Polling::SalesLoftPoller.new(ENV['SALES_LOFT_API_KEY']))
  end
end
