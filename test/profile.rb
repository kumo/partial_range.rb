require File.join(File.dirname(__FILE__), *%w[.. lib partial_range])
require 'benchmark'

Benchmark.bmbm do |x|
  x.report("1000 times sequential"){
    pm = PartialRange.new

    1000.times do |i|
      pm << i
    end
  }

  x.report("1000 times same"){
    pm = PartialRange.new

    1000.times do |i|
      pm << 1
    end
  }

  x.report("1000 times *2"){
    pm = PartialRange.new

    1000.times do |i|
      pm << i*2
    end
  }

  x.report("1000 times random"){
    pm = PartialRange.new

    1000.times do |i|
      pm << rand(100000) # big number otherwise too similar to 'i'
    end
  }
end