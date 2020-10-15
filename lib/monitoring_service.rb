require 'prometheus/client'

class MonitoringService
  attr_reader :client

  def initialize
    @client = Prometheus::Client.registry
    @app_http_requests_count = @client.counter(:app_http_requests_count, docstring: 'A counter of HTTP requests made')
    @app_loop_count = @client.counter(:app_loop_count, docstring: 'A counter of total loop counts')
  end

  def increment_http_requests
    @app_http_requests_count.increment
  end

  def increment_loop_count
    @app_loop_count.increment
  end
end