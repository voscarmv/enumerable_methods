#spec/enumerable_spec.rb
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
  describe "#my_each" do
    let(:a) { [ "a", "b", "c" ] }
    let(:original_method_1) { Proc.new{
      a.each {|x| print x, " -- " }
    } }
    let(:my_method_1) { Proc.new{
      a.my_each {|x| print x, " -- " }
    } }

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
  describe "#my_all?" do

  let(:a) { %w[ant bear cat] }
  let(:original_method_1) { Proc.new{
    a.all? { |word| word.length >= 3 }
  } }
  let(:my_method_1) { Proc.new{
    a.my_all? { |word| word.length >= 3 }
  } }

  let(:original_method_2) { Proc.new{
    a.all? (/t/)  
  } }
  let(:my_method_2) { Proc.new{
    a.my_all? (/t/)  
  } }

  let(:b) { [1, 2i, 3.14] }
  let(:original_method_3) { Proc.new{
    b.all? (Numeric)
  } }
  let(:my_method_3) { Proc.new{
    b.my_all? (Numeric)
  } }

  let(:c) { [nil, true, 99] }
  let(:original_method_4) { Proc.new{
    c.all?
  } }
  let(:my_method_4) { Proc.new{
    c.my_all?
  } }

  let(:d) { [] }
  let(:original_method_5) { Proc.new{
    d.all?
  } }
  let(:my_method_5) { Proc.new{
    d.my_all?
  } }
  

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
end