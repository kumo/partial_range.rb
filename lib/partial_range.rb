# PartialRange
class PartialRange
  def initialize(*options)
    @cached_string = ""
    @cached_array = []

    @ranges = []
    @values = []

    @string_cache_dirty = @values_cache_dirty = false

    if options[0].is_a? Array
      parse_array(options)
    else
      parse_string(options[0])
    end
  end

  def self.parse_to_string(options)
    PartialRange.new(options).to_s
  end

  def self.parse_to_list(options)
    PartialRange.new(options).to_a
  end

  def to_s
    if @string_cache_dirty
      create_string_cache
      @string_cache_dirty = false
    end

    @cached_string
  end

  def to_a
    if @values_cache_dirty
      create_array_cache
      @values_cache_dirty = false
    end

    @cached_array
  end

  def <<(value)
    if value.is_a? Array
      value.each do |v|
        self << v
      end
    else
      if !process_ranges(value) # value cannot be added to an existing range
        if process_values(value)
          @values_cache_dirty = @string_cache_dirty = true
        else
        end
      else
        @values_cache_dirty = @string_cache_dirty = true
      end
    end
  end

  def length
    if @values_cache_dirty
      create_array_cache
      @values_cache_dirty = false
    end

    @cached_array.length
  end

  protected

  def create_string_cache
    results = []

    combined = (@ranges << @values).flatten.sort.uniq

    @cached_string = ""

    combined.each do |value|
      if value.is_a? Range
        results << "#{value.first}-#{value.last}"
      else
        results << value
      end
    end

    @cached_string = results.join(",")
  end

  def create_array_cache
    results = []

    combined = (@ranges << @values).flatten.sort.uniq

    combined.map! do |value|
      if value.is_a? Range
        value.to_a
      else
        value
      end
    end

    @cached_array = combined.flatten
  end

  def parse_array(array)
    lowest = highest = nil

    return if array.nil?

    cleaned_array = array.flatten.sort.uniq

    cleaned_array.each do |value|
    if lowest == nil # populate the lowest value if necessary
      lowest = value
      elsif highest == nil # populate the highest value if necessary
        if value == lowest.succ
          highest = value
        else
          @values << lowest
          lowest = value
        end
      else # if we have both high and low values...
        if value == highest.succ # does the value continue the range?
          highest = value
        else # new value doesn't continue range
          @ranges << Range.new(lowest, highest) # write the old range
          highest = nil
          lowest = value # use the value as the new lowest limit
        end
      end
    end

    if highest != nil # if there is a high value then finish the range
      @ranges << Range.new(lowest, highest)
    elsif lowest != nil # if there is a low value then add the value
      @values << lowest
    end

    @string_cache_dirty = @values_cache_dirty = true
  end

  def parse_string(range)
    return if range.nil? or range == ""

    # assume that the string consists of: "a,b,c-e,f"
    cleaned_list = range.split(",") # split the comma separated values

    cleaned_list.sort.each do |entry|
      if entry.include? "-" 
        lowest, highest = entry.split("-")
        if lowest >= highest then # if we have d-a then just add d
          @values << entry.to_i
        else
          @ranges << Range.new(lowest.to_i, highest.to_i) # range to array
        end
      else
        @values << entry.to_i
      end
    end

    @string_cache_dirty = @values_cache_dirty = true
  end

  def check_ranges_and_values
    puts "check ranges #{@ranges.inspect} and values #{@values.inspect}"
    @values = @values.delete_if {|value| ranges_include? value}
    puts "values now #{@values.inspect}"

    cleaned_ranges = []
    @ranges.each do |range|
      idx = @ranges.index(range)
      if idx != 0
        puts "should check if #{range.inspect} [#{idx}] overlaps #{@ranges[idx-1].inspect} or #{@ranges[idx+1].inspect}"
      else
        puts "should check if #{range.inspect} [#{idx}] overlaps #{@ranges[idx+1].inspect}"
      end

      if ranges_include? range.first
        puts "low range found"
      elsif ranges_include? range.last
        puts "high range found"
      else
        puts "nothing found"
      end
    end
  end

  def process_ranges(value)
    return false unless @ranges.any?
    return true if ranges_include?(value)
    changed = false
    combinable_range_idx = nil

    @values.delete(value) if @values.include? value

    @ranges.collect! do |range|
      if range.last + 1 == value
        changed = true
        if @values.include? value + 1
          @values.delete(value+1)
          Range.new(range.first, value + 1)
        else
          Range.new(range.first, value)
        end
      elsif range.first - 1 == value
        if changed # there is a range with the higher bound the same
          combinable_range_idx = @ranges.index(range)
        end
        changed = true
        if @values.include? value - 1
          @values.delete(value-1)
          Range.new(value - 1, range.last)
        else
          Range.new(value, range.last)
        end
      else
        range
      end
    end

    unless combinable_range_idx.nil?
      combinable_range = @ranges[combinable_range_idx]
      previous_range = @ranges[combinable_range_idx - 1]
      range = Range.new(previous_range.first, combinable_range.last)
      @ranges.delete(previous_range)
      @ranges.delete(combinable_range)
      @ranges << range
    end

    cleanup_ranges if changed
    return changed
  end

  def process_values(value)
    if !@values.include? value
      @values << value
      @values.sort!

      pos = @values.index(value)
      lower_value = @values[pos-1]
      upper_value = @values[pos+1]
      if lower_value == value - 1 or upper_value == value + 1
        if lower_value == value - 1 and upper_value == value + 1
          @ranges << Range.new(lower_value, upper_value)
          @values.delete(lower_value)
          @values.delete(upper_value)
        elsif @values[pos-1] == value - 1
          @ranges << Range.new(lower_value, value)
          @values.delete(lower_value)
        elsif @values[pos+1] == value + 1
          @ranges << Range.new(value, upper_value)
          @values.delete(upper_value)
        end
        @values.delete(value)
        @values_dirty = true
        cleanup_ranges
      end

      return true
    else
      return false
    end
  end

  def ranges_include?(value)
    @ranges.each do |range|
      return true if range.include? value
      return false if range.first > value
    end

    return false
  end

  def cleanup_ranges
    @ranges.sort!
  end
end

class Range
  def <=>(other)
    low = self.first
    other_low = other.is_a?(Range) ? other.first : other
    result = low <=> other_low
    return result
  end
end

class Fixnum
  alias_method :old_compare, :<=>
  def <=>(other)
    if other.is_a? Range
      low = self
      other_low = other.first

      result = low <=> other_low
      return result
    else
      result = old_compare(other)
      return result
    end
  end
end