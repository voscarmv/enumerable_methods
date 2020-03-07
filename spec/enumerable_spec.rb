#spec/enumerable_spec.rb
require './main.rb'

def with_captured_stdout
  original_stdout = $stdout
  $stdout = StringIO.new
  yield
  $stdout.string
ensure
  $stdout = original_stdout
end

RSpec.describe Enumerable do
  describe "#my_each" do
    let(:a) { [ "a", "b", "c" ] }
    let(:original_method_1) { Proc.new{a.each {|x| print x, " -- " }} }
    let(:my_method_1) { Proc.new{a.my_each {|x| print x, " -- " }} }
    it 'standard output of #my_each with code block' do
      original_output = with_captured_stdout(&original_method_1)
      expect(&my_method_1).to output(original_output).to_stdout
    end
    it 'return value of #my_each with code block' do
      expect(my_method_1.call).to eql(original_method_1.call)
    end
    # it 'using #my_each without a code block' do

    # end
  end
end