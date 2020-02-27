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
end

[1, 2, 3].my_each
[4, 5, 6].my_each {|x| puts x+2}

