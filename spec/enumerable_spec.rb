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
    my_method =
    original_output = with_captured_stdout { a.each {|x| print x, " -- " } }
    expect{a.my_each {|x| print x, " -- " }}.to output(original_output).to_stdout
    expect(a.my_each {|x| print x, " -- " }).to eql(a.each {|x| print x, " -- " })
    end
    it 'using #my_each without a code block' do

    end
  end
end