require 'spec_helper'

describe ArgumentsParser do
	
	describe :parse do

		before :all do
			@args = ['-c', 'spec spec', 'cucumber', '-d', 'lib', 'spec']
		end
		
		it "returns all keys found before finding a key with a preceding dash" do
			@result = ArgumentsParser.parse('-c', @args)
			@result.should == ['spec spec', 'cucumber']
		end

		it "returns the rest of the keys when the flag is the last flag in the array" do
			@result = ArgumentsParser.parse('-d', @args)
			@result.should == ['lib', 'spec']
		end

		it "handles consecutive calls using the same array" do
			args2 = ['-c', 'echo "hello world"', '-d', 'test-files/']
			r1 = ArgumentsParser.parse('-c', args2)
			r2 = ArgumentsParser.parse('-d', args2)
			r1.should == ['echo "hello world"']
			r2.should == ['test-files/']
		end
	end

end
