require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib partial_range])

class TestPartialRangeArrayInitialize < Test::Unit::TestCase
  def test_empty_init
    partial_range = PartialRange.new

    assert_equal "", partial_range.to_s
    assert_equal [], partial_range.to_a
    assert_equal 0, partial_range.length
  end

  def test_empty_string_init
    partial_range = PartialRange.new("")

    assert_equal "", partial_range.to_s
    assert_equal [], partial_range.to_a
    assert_equal 0, partial_range.length
  end

  def test_string_init
    partial_range = PartialRange.new("1")

    assert_equal "1", partial_range.to_s
    assert_equal [1], partial_range.to_a
    assert_equal 1, partial_range.length
  end

  def test_range_string_init
    partial_range = PartialRange.new("1-5")

    assert_equal "1-5", partial_range.to_s
    assert_equal [1,2,3,4,5], partial_range.to_a
    assert_equal 5, partial_range.length
  end

  def test_mixed_touching_ranges
    partial_range = PartialRange.new("1,2-5")

    assert_equal "1-5", partial_range.to_s
    assert_equal [1,2,3,4,5], partial_range.to_a
    assert_equal 5, partial_range.length
  end

  def test_touching_ranges
    partial_range = PartialRange.new("1-3,4-5")

    assert_equal "1-5", partial_range.to_s
    assert_equal [1,2,3,4,5], partial_range.to_a
    assert_equal 5, partial_range.length
  end

  def test_overlapping_range_string_init
    partial_range = PartialRange.new("1-5,3-7")

    assert_equal "1-7", partial_range.to_s
    assert_equal [1,2,3,4,5,6,7], partial_range.to_a
    assert_equal 7, partial_range.length
  end

  def test_unorded_overlapping_range_string_init
    partial_range = PartialRange.new("3-7,1-5,5-10")

    assert_equal "1-10", partial_range.to_s
    assert_equal [1,2,3,4,5,6,7,8,9,10], partial_range.to_a
    assert_equal 10, partial_range.length
  end

  def test_mixing_ranges_singles_string_init
    partial_range = PartialRange.new("1-3,5,7-10")

    assert_equal "1-3,5,7-10", partial_range.to_s
    assert_equal [1,2,3,5,7,8,9,10], partial_range.to_a
    assert_equal 8, partial_range.length
  end

  def test_mixing_same_ranges_singles_string_init
    partial_range = PartialRange.new("1-5,3,7,2,1,4,5")

    assert_equal "1-5,7", partial_range.to_s
    assert_equal [1,2,3,4,5,7], partial_range.to_a
    assert_equal 6, partial_range.length
  end

  def test_expanding_ranges_with_singles_string_init
    partial_range = PartialRange.new("2-5,1,6")

    assert_equal "1-6", partial_range.to_s
    assert_equal [1,2,3,4,5,6], partial_range.to_a
    assert_equal 6, partial_range.length
  end
end
