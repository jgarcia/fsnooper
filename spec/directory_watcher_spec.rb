require 'spec_helper'

describe DirectoryWatcher do

	before :each do
		@args = ["test-files"]
	end


	describe :initialize do 
		
		it "assigns target directories" do 
			@directory_watcher = DirectoryWatcher.new @args
			@directory_watcher.target_directories.should == @args
		end

		it "sets targets changed to false the first time it is run" do
			@directory_watcher = DirectoryWatcher.new @args
			@directory_watcher.targets_changed?.should == false
		end

	end

	describe :watch do

		context "Running for the first time" do 
			
			it "targets changed returns false after the first initialize method" do
				@watcher = DirectoryWatcher.new @args
				@watcher.watch
				@watcher.targets_changed?.should == false
			end

		end

		context "Adding new files and folders" do
			
			before :each do
				@directory_watcher = DirectoryWatcher.new @args
			end

			after :each do
				system("rm -r test-files  && mkdir test-files")
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

		context "Modifying files" do

			it "sets targets_changed? to true when a file is modified" do
				watcher = DirectoryWatcher.new @args
				system('touch test-files/some_file.rb')
				watcher.watch
				sleep 1
				system('touch test-files/some_file.rb')
				watcher.watch
				watcher.targets_changed?.should == true
			end

		end

	end

end
