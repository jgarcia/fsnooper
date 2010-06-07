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

		def mock_directory_watcher(stubs={})
			@mock_directory_watcher ||= mock(DirectoryWatcher,stubs)
		end
		
		before :each do
			mock_directory_watcher({:watch => nil,:targets_changed? => false})
			DirectoryWatcher.stub(:new).and_return(mock_directory_watcher)
			@args = ["-c", "spec spec", "-d", "."]
			ArgumentsParser.should_receive(:parse).with("-c", @args).and_return("spec spec")
			ArgumentsParser.should_receive(:parse).with("-d", @args).and_return(".")
			@fsnooper = FSnooper.new @args
		end

		it "watches the target directories" do
			mock_directory_watcher.should_receive(:watch)
			@fsnooper.run
		end

		it "runs the commands if target directories change" do
			mock_directory_watcher.stub(:targets_changed?).and_return(true)
			@fsnooper.run
		end
		
	end

end
