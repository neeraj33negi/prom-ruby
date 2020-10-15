require 'prometheus/client'

class MonitoringService
  def initialize(application)
    @client = Prometheus::Client.registry
    @http_requests = @client.counter.new(:http_requests, docstring: 'A counter of HTTP requests made')
    @loop_count = @client.counter.new(:loop_count, docstring: 'A counter of total loop counts')
  end

  def increment_http_requests
    @http_requests.increment
  end

  def increment_loop_count
    @loop_count.increment
  end
end