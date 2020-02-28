# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
module Enumerable
  def my_each
    if block_given?
      (0..length - 1).each do |i|
        yield(self[i])
      end
      self
    else
      to_enum
    end
  end

  def my_each_with_index
    if block_given?
      (0..length - 1).each do |i|
        yield(self[i], i)
      end
    else
      to_enum
    end
  end

  def my_select
    if block_given?
      output = []
      (0..length - 1).each do |i|
        output << self[i] if yield(self[i])
      end
      output
    else
      to_enum
    end
  end

  def my_each_check_all
    (0..length - 1).each do |i|
      return false unless yield(self[i])
    end
    true
  end

  def my_all?(expr = nil)
    if expr.class == Regexp
      my_each_check_all { |i| i =~ expr }
    elsif expr.class == Class
      my_each_check_all { |i| i.is_a? expr }
    elsif block_given?
      my_each_check_all { |i| yield(i) }
    else
      my_each_check_all { |i| i == false || i.nil? }
    end
  end

  def my_each_check_none
    (0..length - 1).each do |i|
      return false if yield(self[i])
    end
    true
  end

  def my_none?(expr = nil)
    if expr.class == Regexp
      my_each_check_none { |i| i =~ expr }
    elsif expr.class == Class
      my_each_check_none { |i| i.is_a? expr }
    elsif block_given?
      my_each_check_none { |i| yield(i) }
    else
      my_each_check_none { |i| i == false || i.nil? }
    end
  end

  def my_count(obj = nil)
    output = 0
    if !obj.nil?
      (0..length - 1).each do |i|
        output += 1 if self[i] == obj
      end
      output
    elsif block_given?
      (0..length - 1).each do |i|
        output += 1 if yield(self[i])
      end
      output
    else
      length
    end
  end

  def my_map(proc = nil)
    output = []
    if proc.class == Proc
      (0..length - 1).each do |i|
        output << proc.call(self[i])
      end
      output
    elsif block_given?
      (0..length - 1).each do |i|
        output << yield(self[i])
      end
      output
    else
      to_enum
    end
  end

  def my_inject(first = nil, second = nil)
    accum = self[0]
    if first.class == Symbol
      (1..length - 1).each do |i|
        accum = accum.send(first, self[i])
      end
      accum
    elsif !first.class.nil? && second.nil?
      accum = first
      if block_given?
        (0..length - 1).each do |i|
          accum = yield(accum, self[i])
        end
      else
        (0..length - 1).each do |i|
          accum = accum.send(first, self[i])
        end
      end
      accum
    elsif !first.class.nil? && second.class == Symbol
      accum = first
      (0..length - 1).each do |i|
        accum = accum.send(second, self[i])
      end
      accum
    elsif first.nil? && second.nil?
      if block_given?
        (1..length - 1).each do |i|
          accum = yield(accum, self[i])
        end
        accum
      end
    end
  end

  def multiply_els
    my_inject(:*)
  end
end
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity

[1, 2, 3].my_each
[4, 5, 6].my_each { |x| puts x + 2 }

[1, 2, 3].each
[4, 5, 6].each { |x| puts x + 2 }

[7, 9, 10].my_each_with_index
[7, 9, 10].my_each_with_index { |x| puts(x * x).to_s }
[7, 9, 10].my_each_with_index { |x, y| puts "#{x + y} #{y}" }

[7, 9, 10].each_with_index
[7, 9, 10].each { |x| puts(x * x).to_s }
[7, 9, 10].each_with_index { |x, y| puts "#{x + y} #{y}" }

[0, 0, 0, 1, 0, 2].my_select
[0, 0, 0, 1, 0, 2].my_select(&:positive?)

[0, 0, 0, 1, 0, 2].select
[0, 0, 0, 1, 0, 2].select(&:positive?)

%w[oscar apple dark].my_all?(/a/)
%w[oscar apple dark].my_all?(/b/)
[7, 1, 2, 3, 4, 5].my_all? { |x| x > 9 }
[7, 1, 2, 3, 4, 5].my_all?(&:positive?)
[1, 2i, 3.14].my_all?(Numeric)
[1, 2, 3].my_all?(Integer)
[9, 'abc', 0].my_all?(Integer)

%w[oscar apple dark].all?(/a/)
%w[oscar apple dark].all?(/b/)
[7, 1, 2, 3, 4, 5].all? { |x| x > 9 }
[7, 1, 2, 3, 4, 5].all?(&:positive?)
[1, 2i, 3.14].all?(Numeric)
[1, 2, 3].all?(Integer)
[9, 'abc', 0].all?(Integer)

%w[oscar apple dark].my_none?(/a/)
%w[oscar apple dark].my_none?(/b/)
[7, 1, 2, 3, 4, 5].my_none? { |x| x > 9 }
[7, 1, 2, 3, 4, 5].my_none?(&:positive?)
[1, 2i, 3.14].my_none?(Numeric)
[1, 2, 3].my_none?(Integer)
[9, 'abc', 0].my_none?(Integer)

%w[oscar apple dark].none?(/a/)
%w[oscar apple dark].none?(/b/)
[7, 1, 2, 3, 4, 5].none? { |x| x > 9 }
[7, 1, 2, 3, 4, 5].none?(&:positive?)
[1, 2i, 3.14].none?(Numeric)
[1, 2, 3].none?(Integer)
[9, 'abc', 0].none?(Integer)

[0, 2, 3, 4, 5, 1, 2, 2, 3].my_count(1)
[0, 2, 3, 4, 5, 1, 2, 2, 3].my_count(2)
[0, 2, 3, 4, 5, 1, 2, 2, 3].my_count(3)
[0, 2, 3, 4, 5, 1, 2, 2, 3].my_count { |i| i > 2 }
[0, 2, 3, 4, 5, 1, 2, 2, 3].my_count { |i| i < 2 }

[0, 2, 3, 4, 5, 1, 2, 2, 3].count(1)
[0, 2, 3, 4, 5, 1, 2, 2, 3].count(2)
[0, 2, 3, 4, 5, 1, 2, 2, 3].count(3)
[0, 2, 3, 4, 5, 1, 2, 2, 3].count { |i| i > 2 }
[0, 2, 3, 4, 5, 1, 2, 2, 3].count { |i| i < 2 }

[0, 0, 0, 1, 0, 2].my_map
[0, 0, 0, 1, 0, 2].my_map(&:positive?)
myproc = proc { |i| i > 1 }
[0, 0, 0, 1, 0, 2, 3, 4].my_map(myproc)

[0, 0, 0, 1, 0, 2].map
[0, 0, 0, 1, 0, 2].map(&:positive?)
# myproc = proc { |i| i > 1 }
# [0, 0, 0, 1, 0, 2, 3, 4].map(myproc)

[1, 2, 3, 4, 5].my_inject(:+)
[1, 2, 3, 4, 5].my_inject(10, :+)
[1, 2, 3, 4, 5].my_inject(10) { |x, y| x + y }

[1, 2, 3, 4, 5].inject(:+)
[1, 2, 3, 4, 5].inject(10, :+)
[1, 2, 3, 4, 5].inject(10) { |x, y| x + y }

[2, 4, 5].multiply_els
[2, 4, 5].inject(:*)
