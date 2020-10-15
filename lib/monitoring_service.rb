require 'prometheus/client'

class MonitoringService
  def initialize(application)
    @client = Prometheus::Client.registry
    @http_requests = Prometheus::Client::Counter.new(:http_requests, docstring: 'A counter of HTTP requests made', labels: [:requests])
    @loop_count = Prometheus::Client::Counter.new(:loop_count, docstring: 'A counter of total loop counts', labels: [:loop])
    @client.register(@http_requests)
    @client.register(@loop_count)
  end

  def increment_http_requests
    @http_requests.increment
  end

  def increment_loop_count
    @loop_count.increment
  end
end