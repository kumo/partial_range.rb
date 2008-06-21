require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib partial_range])

class TestPartialRangeArrayInitialize < Test::Unit::TestCase
  def test_empty_init
    partial_range = PartialRange.new
    
    assert_equal "", partial_range.to_s
    assert_equal [], partial_range.to_a
    assert_equal 0, partial_range.length
  end

  def test_empty_array_init
    partial_range = PartialRange.new([])

    assert_equal "", partial_range.to_s
    assert_equal [], partial_range.to_a
    assert_equal 0, partial_range.length
  end

  def test_array_init
    partial_range = PartialRange.new([1])

    assert_equal "1", partial_range.to_s
    assert_equal [1], partial_range.to_a
    assert_equal 1, partial_range.length
  end

  def test_consecutive_array_init
    partial_range = PartialRange.new([1,2,3])

    assert_equal "1-3", partial_range.to_s
    assert_equal [1,2,3], partial_range.to_a
    assert_equal 3, partial_range.length
  end
  
  def test_duplicate_array_init
    partial_range = PartialRange.new([1,1,1,1,1,1,1,1,])

    assert_equal "1", partial_range.to_s
    assert_equal [1], partial_range.to_a
    assert_equal 1, partial_range.length
  end

  def test_nested_arrays_init
    partial_range = PartialRange.new([1,2,3],[5,4],[[6],[[7]]],[9,10])

    assert_equal "1-7,9-10", partial_range.to_s
    assert_equal [1,2,3,4,5,6,7,9,10], partial_range.to_a
    assert_equal 9, partial_range.length
  end
  
end
