# spec/enumerable_spec.rb
require './main.rb'

def capture_stdout
  original = $stdout
  $stdout = StringIO.new
  yield
  $stdout.string
ensure
  $stdout = original
end

RSpec.describe Enumerable do
  describe '#my_each' do
    let(:a) { %w[a b c] }
    let(:original_method_1) do
      proc do
        a.each { |x| print x, ' -- ' }
      end
    end
    let(:my_method_1) do
      proc do
        a.my_each { |x| print x, ' -- ' }
      end
    end

    it 'standard output of #my_each with code block' do
      original_output = capture_stdout(&original_method_1)
      expect(&my_method_1).to output(original_output).to_stdout
    end

    it 'return value of #my_each with code block' do
      expect(my_method_1.call).to eql(original_method_1.call)
    end
    # it 'standard output of #my_each without code block' do

    # end
  end
  describe '#my_all?' do
    let(:a) { %w[ant bear cat] }
    let(:original_method_1) do
      proc do
        a.all? { |word| word.length >= 3 }
      end
    end
    let(:my_method_1) do
      proc do
        a.my_all? { |word| word.length >= 3 }
      end
    end

    let(:regex) do
      /t/
    end

    let(:original_method_2) do
      proc do
        a.all? regex
      end
    end
    let(:my_method_2) do
      proc do
        a.my_all? regex
      end
    end

    let(:b) { [1, 2i, 3.14] }
    let(:original_method_3) do
      proc do
        b.all? Numeric
      end
    end
    let(:my_method_3) do
      proc do
        b.my_all? Numeric
      end
    end

    let(:c) { [nil, true, 99] }
    let(:original_method_4) do
      proc do
        c.all?
      end
    end
    let(:my_method_4) do
      proc do
        c.my_all?
      end
    end

    let(:d) { [] }
    let(:original_method_5) do
      proc do
        d.all?
      end
    end
    let(:my_method_5) do
      proc do
        d.my_all?
      end
    end

    it 'standard output of #my_all? with code block' do
      original_output = capture_stdout(&original_method_1)
      expect(&my_method_1).to output(original_output).to_stdout
    end

    it 'return value of #my_all with code block' do
      expect(my_method_1.call).to eql(original_method_1.call)
    end

    it 'standard output with #my_all? with a regular expresion parameter' do
      original_output = capture_stdout(&original_method_2)
      expect(&my_method_2).to output(original_output).to_stdout
    end

    it 'return value of #my_all? with a regular expresion parameter' do
      expect(my_method_2.call).to eql(original_method_2.call)
    end

    it 'standard output with #my_all? with a Numeric class parameter' do
      original_output = capture_stdout(&original_method_3)
      expect(&my_method_3).to output(original_output).to_stdout
    end

    it 'return value of #my_all? with a Numeric class parameter' do
      expect(my_method_3.call).to eql(original_method_3.call)
    end

    it 'standard output with #my_all? with no block and array' do
      original_output = capture_stdout(&original_method_4)
      expect(&my_method_4).to output(original_output).to_stdout
    end

    it 'return value of #my_all? with with no block and array' do
      expect(my_method_4.call).to eql(original_method_4.call)
    end

    it 'standard output with #my_all? with no block and empty array' do
      original_output = capture_stdout(&original_method_5)
      expect(&my_method_5).to output(original_output).to_stdout
    end

    it 'return value of #my_all? with with no block and empty array' do
      expect(my_method_5.call).to eql(original_method_5.call)
    end
  end
  describe '#my_each_with_index' do
    let(:a) { %w[cat dog wombat] }
    let(:original_hash) { {} }
    let(:original_method_1) do
      proc do
        a.each_with_index do |item, index|
          original_hash[item] = index
        end
      end
    end
    let(:my_hash) { {} }
    let(:my_method_1) do
      proc do
        a.my_each_with_index do |item, index|
          my_hash[item] = index
        end
      end
    end

    let(:original_method_2) do
      proc do
        a.each_with_index 
      end
    end
    let(:my_method_2) do
      proc do
        a.my_each_with_index 
      end
    end
    
    it 'standard output with #my_each_with_index' do
      original_output = capture_stdout(&original_method_1)
      expect(&my_method_1).to output(original_output).to_stdout
    end

    it 'return value of #my_each_with_index' do
      expect(my_method_1.call).to eql(original_method_1.call)
    end

    it 'hash value for #my_each_with_index' do
      original_method_1.call
      my_method_1.call
      original_hash.each do |key, value|
        puts key + ' : ' + value.to_s
      end
      my_hash.each do |key, value|
        puts key + ' : ' + value.to_s
      end
      expect(my_hash).to eql(original_hash)
    end

    it 'standard output with #my_each_with_index with no block' do
      original_output = capture_stdout(&original_method_2)
      expect(&my_method_2).to output(original_output).to_stdout
    end

    it 'return value of #my_each_with_index with no block' do
      expect(my_method_2.call).to eql(original_method_2.call)
    end

  end
  describe '#my_any' do
    let(:a) { %w[ant bear cat] }
    let(:original_method_1) do
      proc do
        a.any? { |word| word.length >= 3 }
      end
    end
    let(:my_method_1) do
      proc do
        a.my_any? { |word| word.length >= 3 }
      end
    end

    let(:regex) do
      /d/
    end

    let(:original_method_2) do
      proc do
        a.any? regex
      end
    end
    let(:my_method_2) do
      proc do
        a.my_any? regex
      end
    end

    let(:b) { [nil, true, 99] }
    let(:original_method_3) do
      proc do
        b.any? Integer
      end
    end
    let(:my_method_3) do
      proc do
        b.my_any? Integer
      end
    end

    let(:c) { [nil, true, 99] }
    let(:original_method_4) do
      proc do
        c.any?
      end
    end
    let(:my_method_4) do
      proc do
        c.my_any?
      end
    end

    let(:d) { [] }
    let(:original_method_5) do
      proc do
        d.any?
      end
    end
    let(:my_method_5) do
      proc do
        d.my_any?
      end
    end

    it 'standard output of #my_any? with code block' do
      original_output = capture_stdout(&original_method_1)
      expect(&my_method_1).to output(original_output).to_stdout
    end

    it 'return value of #my_any with code block' do
      expect(my_method_1.call).to eql(original_method_1.call)
    end

    it 'standard output with #my_any? with a regular expresion parameter' do
      original_output = capture_stdout(&original_method_2)
      expect(&my_method_2).to output(original_output).to_stdout
    end

    it 'return value of #my_any? with a regular expresion parameter' do
      expect(my_method_2.call).to eql(original_method_2.call)
    end

    it 'standard output with #my_any? with a Numeric class parameter' do
      original_output = capture_stdout(&original_method_3)
      expect(&my_method_3).to output(original_output).to_stdout
    end

    it 'return value of #my_any? with a Numeric class parameter' do
      expect(my_method_3.call).to eql(original_method_3.call)
    end

    it 'standard output with #my_any? with no block and array' do
      original_output = capture_stdout(&original_method_4)
      expect(&my_method_4).to output(original_output).to_stdout
    end

    it 'return value of #my_any? with with no block and array' do
      expect(my_method_4.call).to eql(original_method_4.call)
    end

    it 'standard output with #my_any? with no block and empty array' do
      original_output = capture_stdout(&original_method_5)
      expect(&my_method_5).to output(original_output).to_stdout
    end

    it 'return value of #my_any? with with no block and empty array' do
      expect(my_method_5.call).to eql(original_method_5.call)
    end
  end
  describe '#my_select' do
    let(:a) { (1..10) }
    let(:original_method_1) do
      proc do
        a.select { |i| i % 3 == 0 }
      end
    end
    let(:my_method_1) do
      proc do
        a.my_select { |i| i % 3 == 0 }
      end
    end

    let(:b) { [1, 2, 3, 4, 5] }
    let(:original_method_2) do
      proc do
        b.select(&:even?)
      end
    end
    let(:my_method_2) do
      proc do
        b.my_select(&:even?)
      end
    end

    let(:c) { %i[foo bar] }
    let(:original_method_3) do
      proc do
        c.select { |x| x == :foo }
      end
    end
    let(:my_method_3) do
      proc do
        c.my_select { |x| x == :foo }
      end
    end

    let(:original_method_4) do
      proc do
        b.select
      end
    end
    let(:my_method_4) do
      proc do
        b.my_select
      end
    end

    it 'standard output with #my_select with range' do
      original_output = capture_stdout(&original_method_1)
      expect(&my_method_1).to output(original_output).to_stdout
    end

    it 'return value of #my_select with range' do
      expect(my_method_1.call).to eql(original_method_1.call)
    end

    it 'standard output with #my_select with array' do
      original_output = capture_stdout(&original_method_2)
      expect(&my_method_2).to output(original_output).to_stdout
    end

    it 'return value of #my_select with array' do
      expect(my_method_2.call).to eql(original_method_2.call)
    end

    it 'standard output with #my_select with symbol array' do
      original_output = capture_stdout(&original_method_3)
      expect(&my_method_3).to output(original_output).to_stdout
    end

    it 'return value of #my_select with symbol array' do
      expect(my_method_3.call).to eql(original_method_3.call)
    end

    it 'standard output with #my_select without block' do
      original_output = capture_stdout(&original_method_3)
      expect(&my_method_3).to output(original_output).to_stdout
    end

    it 'return value of #my_select without block' do
      expect(my_method_3.call).to eql(original_method_3.call)
    end
  end
  describe '#my_none?' do
    let(:a) { %w[ant bear cat] }
    let(:original_method_1) do
      proc do
        a.none? { |word| word.length == 5 }
      end
    end
    let(:my_method_1) do
      proc do
        a.my_none? { |word| word.length == 5 }
      end
    end

    let(:regex) do
      /d/
    end

    let(:original_method_2) do
      proc do
        a.none? regex
      end
    end
    let(:my_method_2) do
      proc do
        a.my_none? regex
      end
    end

    let(:b) { [1, 3.14, 42] }
    let(:original_method_3) do
      proc do
        b.none? Float
      end
    end
    let(:my_method_3) do
      proc do
        b.my_none? Float
      end
    end

    let(:c) { [] }
    let(:original_method_4) do
      proc do
        c.none?
      end
    end
    let(:my_method_4) do
      proc do
        c.my_none?
      end
    end

    let(:d) { [nil] }
    let(:original_method_5) do
      proc do
        d.none?
      end
    end
    let(:my_method_5) do
      proc do
        d.my_none?
      end
    end

    let(:e) { [nil, false] }
    let(:original_method_6) do
      proc do
        e.none?
      end
    end
    let(:my_method_6) do
      proc do
        e.my_none?
      end
    end

    let(:f) { [nil, false, true] }
    let(:original_method_7) do
      proc do
        f.none?
      end
    end
    let(:my_method_7) do
      proc do
        f.my_none?
      end
    end

    it 'standard output with #my_none? with code block' do
      original_output = capture_stdout(&original_method_1)
      expect(&my_method_1).to output(original_output).to_stdout
    end

    it 'return value of #my_none? with code block' do
      expect(my_method_1.call).to eql(original_method_1.call)
    end

    it 'standard output with #my_none? with a regular expresion parameter' do
      original_output = capture_stdout(&original_method_2)
      expect(&my_method_2).to output(original_output).to_stdout
    end

    it 'return value of #my_none? with a regular expresion parameter' do
      expect(my_method_2.call).to eql(original_method_2.call)
    end

    it 'standard output with #my_none? with a Float class parameter' do
      original_output = capture_stdout(&original_method_3)
      expect(&my_method_3).to output(original_output).to_stdout
    end

    it 'return value of #my_none? with a Float class parameter' do
      expect(my_method_3.call).to eql(original_method_3.call)
    end

    it 'standard output with #my_none? with no block and empty array' do
      original_output = capture_stdout(&original_method_4)
      expect(&my_method_4).to output(original_output).to_stdout
    end

    it 'return value of #my_none? with with no block and empty array' do
      expect(my_method_4.call).to eql(original_method_4.call)
    end

    it 'standard output with #my_none? with no block and nil array' do
      original_output = capture_stdout(&original_method_5)
      expect(&my_method_5).to output(original_output).to_stdout
    end

    it 'return value of #my_none? with with no block and nil array' do
      expect(my_method_5.call).to eql(original_method_5.call)
    end

    it 'standard output with #my_none? with no block and nil false array' do
      original_output = capture_stdout(&original_method_6)
      expect(&my_method_6).to output(original_output).to_stdout
    end

    it 'return value of #my_none? with with no block and nil false array' do
      expect(my_method_6.call).to eql(original_method_6.call)
    end

    it 'standard output with #my_none? with no block and nil boolean array' do
      original_output = capture_stdout(&original_method_7)
      expect(&my_method_7).to output(original_output).to_stdout
    end

    it 'return value of #my_none? with with no block and nil boolean array' do
      expect(my_method_7.call).to eql(original_method_7.call)
    end
  end
  describe '#my_count' do
    let(:a) { [1, 2, 4, 2] }
    let(:original_method_1) do
      proc do
        a.count
      end
    end
    let(:my_method_1) do
      proc do
        a.my_count
      end
    end

    let(:original_method_2) do
      proc do
        a.count(2)
      end
    end
    let(:my_method_2) do
      proc do
        a.my_count(2)
      end
    end

    let(:original_method_3) do
      proc do
        a.count(&:even?)
      end
    end
    let(:my_method_3) do
      proc do
        a.my_count(&:even?)
      end
    end

    it 'standard output with #my_count with no code block' do
      original_output = capture_stdout(&original_method_1)
      expect(&my_method_1).to output(original_output).to_stdout
    end

    it 'return value of #my_count with no code block' do
      expect(my_method_1.call).to eql(original_method_1.call)
    end

    it 'standard output with #my_count with parameter' do
      original_output = capture_stdout(&original_method_2)
      expect(&my_method_2).to output(original_output).to_stdout
    end

    it 'return value of #my_count with parameter' do
      expect(my_method_2.call).to eql(original_method_2.call)
    end

    it 'standard output with #my_count with code block' do
      original_output = capture_stdout(&original_method_3)
      expect(&my_method_3).to output(original_output).to_stdout
    end

    it 'return value of #my_count with code block' do
      expect(my_method_3.call).to eql(original_method_3.call)
    end
  end
  describe '#my_map' do
  let(:a) { (1..4) }
  let(:original_method_1) do
    proc do
      a.map { |i| i*i }
    end
  end
  let(:my_method_1) do
    proc do
      a.my_map { |i| i*i }
    end
  end

  let(:original_method_2) do
    proc do
      a.map { "cat"  }
    end
  end
  let(:my_method_2) do
    proc do
      a.my_map { "cat"  }
    end
  end

  let(:original_method_3) do
    proc do
      a.map
    end
  end
  let(:my_method_3) do
    proc do
      a.my_map
    end
  end

  it 'standard output with #my_count with no code block' do
    original_output = capture_stdout(&original_method_1)
    expect(&my_method_1).to output(original_output).to_stdout
  end

  it 'return value of #my_count with no code block' do
    expect(my_method_1.call).to eql(original_method_1.call)
  end

  it 'standard output with #my_count with no code block' do
    original_output = capture_stdout(&original_method_2)
    expect(&my_method_2).to output(original_output).to_stdout
  end

  it 'return value of #my_count with no code block' do
    expect(my_method_2.call).to eql(original_method_2.call)
  end

  it 'standard output with #my_count with no code block' do
    original_output = capture_stdout(&original_method_3)
    expect(&my_method_3).to output(original_output).to_stdout
  end

  it 'return value of #my_count with no code block' do
    expect(my_method_3.call).to eql(original_method_3.call)
  end

  #   (1..4).map { |i| i*i }      #=> [1, 4, 9, 16]
# (1..4).collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
  end
end
