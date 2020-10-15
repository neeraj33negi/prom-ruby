require_relative './src/application'
require 'rack'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'

use Rack::Deflater
use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter

app = Application.new
def run_app
  threads = Concurrent::Array.new
  while(true) do
    app.monitor.increment_loop_count
    puts app.probable_high_cpu_usage
    # threads << Thread.new do
    #   app.make_random_http_requests
    # end
  end
  # thread.map(&:join)
end
run ->(_) do
  app.probable_high_cpu_usage
  app.monitor.increment_loop_count
  app.make_random_http_requests
  [200, {'Content-Type' => 'text/html'}, [Prometheus::Client::Formats::Text.marshal(app.monitor.client)] ]
end