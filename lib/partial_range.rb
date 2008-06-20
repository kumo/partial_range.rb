# PartialRange
class PartialRange
  def initialize(*options)
    @string = ""
    @array = []
    @ranges = []

    options = options[0]
    if options.is_a? Array
      parse_array(options)
    else
      parse_string(options)
    end
  end

  def self.parse_to_string(options)
    PartialRange.new(options).to_s
  end

  def self.parse_to_list(options)
    PartialRange.new(options).to_a
  end

  def to_s
    @string
  end

  def to_a
    @array
  end

  def <<(value)
    if value.is_a? Array
      @array << value.flatten
    else
      if check_ranges(value)
        @array << value
      end
    end
    parse_array(@array)
  end

  def length
    @array.length
  end

  protected

  def parse_array(array)
    lowest = highest = nil
    result = []

    return "" if array.nil?

    @array = array.flatten.sort.uniq

    @array.each do |value|
    if lowest == nil # populate the lowest value if necessary
      lowest = value
      elsif highest == nil # populate the highest value if necessary
        if value == lowest.succ
          highest = value
        else
          result << lowest
          lowest = value
        end
      else # if we have both high and low values...
        if value == highest.succ # does the value continue the range?
          highest = value
        else # new value doesn't continue range
          result << "#{lowest}-#{highest}" # write the old range
          highest = nil
          lowest = value # use the value as the new lowest limit
        end
      end
    end

    if highest != nil # if there is a high value then finish the range
      result << "#{lowest}-#{highest}"
    elsif lowest != nil # if there is a low value then add the value
      result << lowest
    end

    @ranges = []
    
    result.flatten.each do |r|
      if ! r.is_a? Fixnum
        low, high = r.split("-")

        @ranges << Range.new(low.to_i, high.to_i)
      else
        @ranges << Range.new(r, r)
      end
    end
    
    @string = result.flatten.join(",")
  end

  def parse_string(range)
    result = []

    return [] if range.nil?

    @string = range

    # assume that the string consists of: "a,b,c-e,f"
    list = range.split(",") # split the comma separated values

    list.each do |entry|
      if entry.include? "-" 
        lowest, highest = entry.split("-")
        if lowest >= highest then # if we have d-a then just add d
          result << entry.to_i
        else
          result << (lowest.to_i..highest.to_i).to_a # range to array
        end
      else
        result << entry.to_i
      end
    end

    @array = result.flatten.uniq.sort
  end

  def check_ranges(value)
    #puts "There are #{@ranges.size} ranges to check for #{value} (#{value.class})"

    @ranges.each do |range|
      #puts "checking range #{range} -- includes value? #{range.include? value}"
      return false if range.include? value
      #puts "checking if range is higher #{range.first > value}"
      return false if range.first > value
    end

    return true
  end
end
