require File.join(File.dirname(__FILE__), *%w[.. lib partial_range])
require 'benchmark'

Benchmark.bmbm do |x|
  x.report("10 sequential numbers"){
    pm = PartialRange.new

    10.times do |i|
      pm << i
    end
  }

  x.report("100 sequential numbers"){
    pm = PartialRange.new

    100.times do |i|
      pm << i
    end
  }

  x.report("200 sequential numbers"){
    pm = PartialRange.new

    200.times do |i|
      pm << i
    end
  }

  x.report("1000 sequential numbers"){
    pm = PartialRange.new

    1000.times do |i|
      pm << i
    end
  }

  x.report("2000 sequential numbers"){
    pm = PartialRange.new

    2000.times do |i|
      pm << i
    end
  }

  x.report("5000 sequential numbers"){
    pm = PartialRange.new

    5000.times do |i|
      pm << i
    end
  }

  x.report("10 times same"){
    pm = PartialRange.new

    10.times do |i|
      pm << 1
    end
  }

  x.report("100 times same"){
    pm = PartialRange.new

    100.times do |i|
      pm << 1
    end
  }

  x.report("200 times same"){
    pm = PartialRange.new

    200.times do |i|
      pm << 1
    end
  }

  x.report("1000 times same"){
    pm = PartialRange.new

    1000.times do |i|
      pm << 1
    end
  }

  x.report("2000 times same"){
    pm = PartialRange.new

    2000.times do |i|
      pm << 1
    end
  }

  x.report("5000 times same"){
    pm = PartialRange.new

    5000.times do |i|
      pm << 1
    end
  }

  x.report("10 times *2"){
    pm = PartialRange.new

    10.times do |i|
      pm << i * 2
    end
  }

  x.report("100 times *2"){
    pm = PartialRange.new

    100.times do |i|
      pm << i * 2
    end
  }

  x.report("200 times *2"){
    pm = PartialRange.new

    200.times do |i|
      pm << i * 2
    end
  }

  x.report("1000 times *2"){
    pm = PartialRange.new

    1000.times do |i|
      pm << i * 2
    end
  }

  x.report("2000 times *2"){
    pm = PartialRange.new

    2000.times do |i|
      pm << i * 2
    end
  }

  x.report("5000 times *2"){
    pm = PartialRange.new

    5000.times do |i|
      pm << i * 2
    end
  }

  x.report("10 times random"){
    pm = PartialRange.new

    10.times do |i|
      pm << rand(200000) # big number otherwise too similar to 'i'
    end
  }

  x.report("100 times random"){
    pm = PartialRange.new

    100.times do |i|
      pm << rand(200000) # big number otherwise too similar to 'i'
    end
  }

  x.report("200 times random"){
    pm = PartialRange.new

    200.times do |i|
      pm << rand(200000) # big number otherwise too similar to 'i'
    end
  }

  x.report("1000 times random"){
    pm = PartialRange.new

    1000.times do |i|
      pm << rand(200000) # big number otherwise too similar to 'i'
    end
  }

  x.report("2000 times random"){
    pm = PartialRange.new

    2000.times do |i|
      pm << rand(200000) # big number otherwise too similar to 'i'
    end
  }

  x.report("5000 times random"){
    pm = PartialRange.new

    5000.times do |i|
      pm << rand(200000) # big number otherwise too similar to 'i'
    end
  }
end