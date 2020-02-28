module Enumerable
  def my_each
    if block_given?
      for i in 0..self.length-1 do
        yield(self[i])
      end
      self
    else
      self.to_enum
    end
  end

  def my_each_with_index
    if block_given?
      for i in 0..self.length-1 do
        yield(self[i],i)
      end
    else
      self.to_enum
    end
  end

  def my_select
    if block_given?
      output = Array.new
      for i in 0..self.length-1 do
        output << self[i] if yield(self[i])
      end
      output
    else
      self.to_enum
    end
  end

  def my_each_check_all
    for i in 0..self.length-1 do
      return false unless yield(self[i])
    end
    true
  end

  def my_all?(expr = nil)
    if expr.class == Regexp
      self.my_each_check_all {|i| expr === i}
    elsif expr.class == Class
      self.my_each_check_all {|i| i.is_a? expr}
    elsif block_given?
      self.my_each_check_all {|i| yield(i)}
    else
      self.my_each_check_all {|i| i == false || i == nil}
    end
  end

  def my_each_check_none
    for i in 0..self.length-1 do
      return false if yield(self[i])
    end
    true
  end

  def my_none?(expr = nil)
    if expr.class == Regexp
      self.my_each_check_none {|i| expr === i}
    elsif expr.class == Class
      self.my_each_check_none {|i| i.is_a? expr}
    elsif block_given?
      self.my_each_check_none {|i| yield(i)}
    else
      self.my_each_check_none {|i| i == false || i == nil}
    end
  end

  def my_map
    if block_given?
      output = Array.new
      for i in 0..self.length-1 do
        output << yield(self[i])
      end
      output
    else
      self.to_enum
    end
  end
end

[1, 2, 3].my_each
[4, 5, 6].my_each {|x| puts x+2}

[7, 9, 10].my_each_with_index 
[7, 9, 10].my_each_with_index {|x| puts "#{x*x}"}
[7, 9, 10].my_each_with_index {|x,y| puts "#{x+y} #{y}"}

[0, 0, 0, 1, 0, 2].my_select 
[0, 0, 0, 1, 0, 2].my_select {|i| i > 0}

["oscar", "apple", "dark"].my_all?(/a/)
["oscar", "apple", "dark"].my_all?(/b/)
[7, 1, 2, 3, 4, 5].my_all? {|x| x > 9}
[7, 1, 2, 3, 4, 5].my_all? {|x| x > 0}
[1, 2i, 3.14].my_all?(Numeric) 
[1, 2, 3].my_all?(Integer)
[9, "abc", 0].my_all?(Integer)

["oscar", "apple", "dark"].my_none?(/a/)
["oscar", "apple", "dark"].my_none?(/b/)
[7, 1, 2, 3, 4, 5].my_none? {|x| x > 9}
[7, 1, 2, 3, 4, 5].my_none? {|x| x > 0}
[1, 2i, 3.14].my_none?(Numeric) 
[1, 2, 3].my_none?(Integer)
[9, "abc", 0].my_none?(Integer)

[0, 0, 0, 1, 0, 2].my_map 
[0, 0, 0, 1, 0, 2].my_map {|i| i > 0}
