# returns true if +a and +b substrings are separated by +separator in a +string
# returns false otherwise
# see http://ruby-doc.org/core/String.html for help
def separated_by?(string, a, b, separator)
  string.include?(a+separator+b) or string.include?(b+separator+a)
end

# returns true if +string reads the same way from both ends, e.g. krk
# returns false otherwise
def palindrom?(string)
  string == string.reverse
end

# return count of palindroms in +array
def palindroms_count(array)
  array.select{|i| palindrom?(i)}.count
end

# returns true if +number is power of 2, e.g. 4, 8, 16
# returns false otherwise
def power_of_2?(number)
  !number.to_s(2).match(/\A10*\Z/).nil?
end

# returns a hash, +keys is an array of keys, +values is an array of values
# so that build_hash_from([1, 'a'], ['one', 'A']) will return { 1 => 'one', 'a' => 'A' }
# hash should have as many entries as keys, if there are no values for keys use nil
def build_hash_from(keys, values)
  Hash[*keys.zip(values).flatten]
end
