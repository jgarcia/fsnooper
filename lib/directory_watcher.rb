class DirectoryWatcher
	attr_accessor :target_directories
	
	def initialize(target_directories)
		self.target_directories = target_directories
	end

	def watch
		#make sure that the new files array is clean before adding any new files
		@new_files = []
		#scan the target directories
			
		if targets_changed?
			@current_files = @new_files
		end
	end

	def targets_changed?
		@new_files.count != @current_files.count
	end

	def scan_files
		base_dir = Dir.pwd
		self.target_directories.each do |directory|
			Dir.chdir(directory)
			@new_files << Dir.glob('**/*.*')
			Dir.chdir(base_dir)
		end
	end

end
