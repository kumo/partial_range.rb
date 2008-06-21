require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib partial_range])

class TestPartialRangeClassMethods < Test::Unit::TestCase
  def test_empty_string
    list = PartialRange.parse_to_list("")
    assert_equal [], list

    list = PartialRange.parse_to_list(nil)
    assert_equal [], list
  end

  def test_empty_array
    string = PartialRange.parse_to_string([])
    assert_equal "", string

    string = PartialRange.parse_to_string(nil)
    assert_equal "", string
  end

  def test_simple_array
    list = PartialRange.parse_to_list("1")
    assert_equal [1], list

    list = PartialRange.parse_to_list("1,2")
    assert_equal [1,2], list

    list = PartialRange.parse_to_list("1,2,1")
    assert_equal [1,2], list

    list = PartialRange.parse_to_list("2,2,1")
    assert_equal [1,2], list
  end

  def test_simple_range
    list = PartialRange.parse_to_list("1-3")
    assert_equal [1,2,3], list

    list = PartialRange.parse_to_list("1-3,2")
    assert_equal [1,2,3], list

    list = PartialRange.parse_to_list("1-3,6")
    assert_equal [1,2,3,6], list
  end

  def test_longer_range
    list = PartialRange.parse_to_list("1-3,3-6,2-9,11")
    assert_equal [1,2,3,4,5,6,7,8,9,11], list

    list = PartialRange.parse_to_list("1-3,5,8-6,11")
    assert_equal [1,2,3,5,8,11], list
    assert list.include?(3)
    assert ! list.include?(6)
    assert list.include?(8)
  end

  def test_inclusion
    list = PartialRange.parse_to_list("1-3,5,8-6,11")
    assert list.include?(3)
    assert ! list.include?(6)
    assert list.include?(8)
  end

  def test_string_simple
    string = PartialRange.parse_to_string([1])
    assert_equal "1", string

    string = PartialRange.parse_to_string([1,3])
    assert_equal "1,3", string

    string = PartialRange.parse_to_string([1,3,8,5])
    assert_equal "1,3,5,8", string
  end

  def test_string_range
    string = PartialRange.parse_to_string([1,2])
    assert_equal "1-2", string

    string = PartialRange.parse_to_string([1,1])
    assert_equal "1", string

    string = PartialRange.parse_to_string([1,2,3,4,6,5])
    assert_equal "1-6", string

    string = PartialRange.parse_to_string([1,2,3,5,6,10,11,12,13,8])
    assert_equal "1-3,5-6,8,10-13", string
  end

  def test_string_to_flatten
    string = PartialRange.parse_to_string([1,[2,3]])
    assert_equal "1-3", string
  end

  def test_both
    assert_equal PartialRange.parse_to_string([1,2,3,5,6,10,11,12,13,8]),
      PartialRange.parse_to_string(PartialRange.parse_to_list("1-3,5-6,8,10-13"))
  end
end
