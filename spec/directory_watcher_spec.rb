require 'spec_helper'

describe DirectoryWatcher do

	before :each do
		@args = ["test-files", "spec"]	
	end

	describe :initialize do 
		
		it "assigns target directories" do 
			@directory_watcher = DirectoryWatcher.new @args
			@directory_watcher.target_directories.should == @args
		end

	end

	describe :watch do

		before :each do
			@directory_watcher = DirectoryWatcher.new @args
		end

		it "sets the targets_changed flag to true when a new file is added to the target directory" do 
			system('touch test-files/somefile.rb')
			@directory_watcher.watch
			@directory_watcher.targets_changed?.should == true
		end

		it "sets the targets_changed? flag to false when a new directory has been added to the target directory" do
			system('mkdir test-files/some-dir')
			@directory_watcher.watch
			@directory_watcher.targets_changed?.should == false
		end
	
	end

end
