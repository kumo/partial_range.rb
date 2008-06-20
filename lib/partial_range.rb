# PartialRange
class PartialRange
  def initialize
  end

  def parse_array(array)
    lowest = highest = nil
    result = []

    array.flatten.sort.uniq.each do |value|
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
					yield lowest, highest
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
		
		result.flatten.join(",")
	end

	
def PartialRange.parse_to_list(range)
		# assume that the string consists of: "a,b,c-e,f"
		list = range.split(",") # split the comma separated values
		
		result = []
		
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
		
		result.flatten.uniq.sort
	end
	
	def PartialRange.parse_to_string(array)
		lowest = highest = nil
		result = []
		
		array.flatten.sort.uniq.each do |value|
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
		
		result.flatten.join(",")
	end
end

