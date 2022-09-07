PartialRange
============

[![Ruby](https://github.com/kumo/partial_range.rb/actions/workflows/ruby.yml/badge.svg)](https://github.com/kumo/partial_range.rb/actions/workflows/ruby.yml)

PartialRange is a simple parser that can convert an array of numbers into a string (e.g. from [1,2,3,5] into "1-3,5") or turn a string into an array of numbers (e.g. from "1,2,1,2-3" into [1,2,3]).

I think that I once wrote this code to help me understand if I was missing episodes from an anime. From a list of filenames I would extract the episode numbers and then see if any were missing.


## Examples

````
partial_range = PartialRange.new
partial_range << 1
partial_range << 2
partial_range << 3
partial_range << 5

partial_range.to_s
 -> "1-3,5"

partial_range.to_a
 -> [1,2,3,5]
````

Create a `PartialRange` from a string:

````
partial_range = PartialRange.new("1-5,7-10")
partial_range.to_a
 -> [1,2,3,4,5,7,8,9,10]
````

Create a `PartialRange` from an array:

````
partial_range = PartialRange.new([1,3,4,8,9,10])
partial_range.to_s
 -> "1,3-4,8-10"
````

Copyright (c) 2014 Rob Clarke (kumo), released under the MIT license
