#!/usr/bin/env ruby

# take in desired message
#
# What date should this start from?

# make sure it's within some limits. Length, check characters

# check the repo this will generate commits on
# -> you should copy this script to a test repo you don't care about

# check the darkest square (possible through github API?) and use that as the
# desired contribution limit per square

# parse those characters from the array set

# work out co-ordinates to date (also taking into account offset)

# "this is what your message will look like, is this OK?"

# commit the shift out of that date

# inputs:
# - message
# - date to take as "top left"
# - github credentials (optional, use API to make sure dates with contributions
#   are accounted for, and to get max contribution count)

# are Sundays always on top for the contribution summary?

# character constants
load 'characters.rb'

# github contribution summary is 54ish wide
# each character is 4x5 (with 1px gap at right) so 13 character max depending
# on starting offset
width = 52
lines = 7
# where to start the message in the array in for form [y,x]
offset = [1,5]

# if Array.new uses (lines, Array.new...) then same object is used for each line
# which means a change to one line = a change to them all. Instead use block
# variant so different objects are used
output = Array.new(lines) { Array.new(width, 0) }

def add_character(character, output, offset)
    # output = output array
    # character = character array
    # offset = offset in form [ y offset, x offset ] e.g. [1,2]
    # TODO can this be done with a map + reduce instead?
    for n in (0..character.size-1) do
        # for every block in the line
        for m in (0..character[0].size-1)
            # add to output
            output[n + offset[0]][m + offset[1]] = character[n][m]
        end
    end
    return output
end

output = add_character(Y, output, offset)
offset[1] += 4
output = add_character(O, output, offset)
offset[1] += 4
output = add_character(BANG, output, offset)

# print output
output.each do |line|
    line.each do |val|
        #TODO make print actually representative (maybe HTML?)
        print val == 1 ? "■" : "□"
    end
    print "\n"
end
