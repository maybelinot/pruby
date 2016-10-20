module StringExtensions
  def separated_by?(a, b, separator)
    self.include?(a+separator+b) or self.include?(b+separator+a)
  end

  def palindrom?(string)
    self == self.reverse
  end
end

module NumericExtensions
  def power_of_2?()
    !self.to_s(2).match(/\A10*\Z/).nil?
  end
end

module ArrayExtensions
  def build_hash_from(keys, values)
    Hash[*keys.zip(values).flatten]
  end
  def palindroms_count()
    self.select{|i| palindrom?(i)}.count
  end
end

class String
  include StringExtensions
end

class Numeric
  include NumericExtensions
end

class Array
  include ArrayExtensions
end
