require 'typhoeus'
require 'concurrent'
require_relative '../lib/monitoring_service'

class Application
  attr_accessor :monitor

  def initialize
    @monitor = MonitoringService.new
  end

  def make_random_http_requests
    5.times do
      @monitor.increment_http_requests
      Typhoeus.get("www.example.com")
    end
  end

  def probable_high_cpu_usage
    high_cpu_usage if rand(10) > 5
  end

  private def high_cpu_usage
    factorial(15 + rand(5))
  end

  private def factorial(n)
    return 1 if n <= 1
    return n * factorial(n - 1)
  end
end

app = Application.new
threads = Concurrent::Array.new
while(true) do
  @monitor.increment_loop_count
  puts app.probable_high_cpu_usage
  threads << Thread.new do
    app.make_random_http_requests
  end
end
thread.map(&:join)