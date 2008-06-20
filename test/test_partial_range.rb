require 'test/unit'
require File.join(File.dirname(__FILE__), *%w[.. lib partial_range])

class PartialRangeTest < Test::Unit::TestCase
  def setup
    @partial_range = PartialRange.new
  end

  def test_initial_state
    assert_equal "", @partial_range.to_s
    assert_equal [], @partial_range.to_a
    assert_equal 0, @partial_range.length
  end

  def test_adding_something
    @partial_range << 1

    assert_equal "1", @partial_range.to_s
    assert_equal [1], @partial_range.to_a
    assert_equal 1, @partial_range.length
  end

  def test_adding_multiple_consecutive_values
    1.upto(3) do |i|
      @partial_range << i
    end

    assert_equal "1-3", @partial_range.to_s
    assert_equal [1,2,3], @partial_range.to_a
    assert_equal 3, @partial_range.length
  end

  def test_adding_unordered_multiple_values
    @partial_range << 3
    @partial_range << 1
    @partial_range << 6
    @partial_range << 2

    assert_equal "1-3,6", @partial_range.to_s
    assert_equal [1,2,3,6], @partial_range.to_a
    assert_equal 4, @partial_range.length
  end

  def test_adding_array_of_multiple_consecutive_values
    @partial_range << [1,2,3]

    assert_equal "1-3", @partial_range.to_s
    assert_equal [1,2,3], @partial_range.to_a
    assert_equal 3, @partial_range.length
  end

  def test_adding_duplicate_values
    3.times do
      @partial_range << 1
    end

    assert_equal "1", @partial_range.to_s
    assert_equal [1], @partial_range.to_a
    assert_equal 1, @partial_range.length
  end

  def test_adding_multiple_disjoint_values
    1.upto(3) do |i|
      @partial_range << i * 2
    end

    assert_equal "2,4,6", @partial_range.to_s
    assert_equal [2,4,6], @partial_range.to_a
    assert_equal 3, @partial_range.length
  end

  def test_adding_disjoint_consecutive_values
    1.upto(3) do |i|
      @partial_range << i
      @partial_range << i + 10
    end

    assert_equal "1-3,11-13", @partial_range.to_s
    assert_equal [1,2,3,11,12,13], @partial_range.to_a
    assert_equal 6, @partial_range.length
  end
end
