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
    it 'standard output and return of #my_each using a code block' do
    a = [ "a", "b", "c" ]
    original_method = Proc.new{
      a.each {|x| print x, " s-- " }
    }
    my_method = Proc.new{  
      a.my_each {|x| print x, " -- " }
    }
    original_output = with_captured_stdout(&original_method)
    expect(&my_method).to output(original_output).to_stdout
    expect(my_method.call).to eql(original_method.call)
    end
    # it 'using #my_each without a code block' do

    # end
  end
end