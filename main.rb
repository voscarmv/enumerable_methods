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
end

[1, 2, 3].my_each
[4, 5, 6].my_each! {|x| puts x+2}

[7, 9, 10].my_each_with_index {|x| puts "#{x*x}"}
[7, 9, 10].my_each_with_index {|x,y| puts "#{x+y} #{y}"}

