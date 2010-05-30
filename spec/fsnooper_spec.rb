require "spec_helper"

describe FSnooper do

	describe "initialize" do 

		before :each do 
			@args = ["-c", "spec spec", "-d", "."]
			ArgumentsParser.stub(:parse)
			DirectoryWatcher.stub(:new)
		end

		it "parses out the parameters" do
			ArgumentsParser.should_receive(:parse).with("-c", @args).and_return("spec spec")
			ArgumentsParser.should_receive(:parse).with("-d", @args).and_return(".")
			fsnooper = FSnooper.new @args
			fsnooper.commands.should == "spec spec"
			fsnooper.target_directories.should == "."
		end

		it "initializes the directory watcher with the target directories" do 
			DirectoryWatcher.should_receive(:new).with(".")
			ArgumentsParser.should_receive(:parse).with("-d", @args).and_return(".")
			fsnooper = FSnooper.new @args
		end

	end

	describe "run" do
		
	end
end
