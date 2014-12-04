PartialRange
============

![Build Status](https://travis-ci.org/kumo/partial_range.rb.svg?branch=master)

PartialRange is a simple parser that can convert an array of numbers into a string (e.g. from [1,2,3,5] into "1-3,5") or turn a string into an array of numbers (e.g. from "1,2,1,2-3" into [1,2,3]).

I think that I once wrote this code to help me understand if I was missing episodes from an anime. From a list of filenames I would extract the episode numbers and then see if any were missing.


Examples
========

@pr = PartialRange.new
@pr << 1
@pr << 2
@pr << 3
@pr << 5

@pr.to_s
 -> "1-3,5"

@pr.to_a
 -> [1,2,3,5]

@pr = PartialRange.new("1-5,7-10")
@pr.to_a
 -> [1,2,3,4,5,7,8,9,10]

@pr = PartialRange.new([1,3,4,8,9,10])
@pr.to_s
 -> "1,3-4,8-10"


Copyright (c) 2008 Rob Clarke (kumo), released under the MIT license
