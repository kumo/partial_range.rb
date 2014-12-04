require 'partial_range'

describe 'PartialRange' do

  [
    [ [1], "1" ],
    [ [1,2], "1-2" ],
    [ [1,2,3], "1-3" ],
    [ [1,2,4,5,6], "1-2,4-6" ],
  ].each do |range_pair|

    it "returns #{range_pair[1]} for array #{range_pair[0]}" do
      partialRange = PartialRange.new(range_pair[0])
      expect(partialRange.to_s).to eq(range_pair[1])
    end

  end

  [
    [ "1", [1] ],
    [ "1,2", [1,2] ],
    [ "1,2,3", [1,2,3] ],
    [ "1-4", [1,2,3,4] ],
    [ "1-3,4-6", [1,2,3,4,5,6] ],
    [ "1-3,5-7", [1,2,3,5,6,7] ],
    [ "1-3,4-6,7-10", [1,2,3,4,5,6,7,8,9,10] ],
    [ "1-3,4-10", [1,2,3,4,5,6,7,8,9,10] ],
    [ "1,2-5", [1,2,3,4,5] ],
    [ "1,2-4,5", [1,2,3,4,5] ],
  ].each do |range_pair|

    it "returns #{range_pair[1]} for string #{range_pair[0]}" do
      partialRange = PartialRange.new(range_pair[0])
      expect(partialRange.to_a).to eq(range_pair[1])
    end

  end

end
