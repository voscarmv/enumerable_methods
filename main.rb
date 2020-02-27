module Enumerable
  def my_each
    Enumerator.new(self)
  end
end

[1, 2, 3].each

