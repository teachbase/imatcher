$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'benchmark/ips'
require 'imatcher'

a = Imatcher::Image.from_file(File.expand_path('../../spec/fixtures/a.png', __FILE__))
b = Imatcher::Image.from_file(File.expand_path('../../spec/fixtures/a.png', __FILE__))

rgb = Imatcher::Matcher.new
grayscale = Imatcher::Matcher.new mode: :grayscale
delta = Imatcher::Matcher.new mode: :delta

Benchmark.ips do |x|
  x.report 'RGB' do
    rgb.compare(a, b)
  end

  x.report 'Grayscale' do
    grayscale.compare(a, b)
  end

  x.report 'Delta E' do
    delta.compare(a, b)
  end

  x.compare!
end

Benchmark.ips do |x|
  x.report 'RGB' do
    rgb.compare(a, b).difference_image
  end

  x.report 'Grayscale' do
    grayscale.compare(a, b).difference_image
  end

  x.report 'Delta E' do
    delta.compare(a, b).difference_image
  end

  x.compare!
end
