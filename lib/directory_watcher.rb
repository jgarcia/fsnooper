class DirectoryWatcher
	attr_accessor :target_directories
	
	def initialize(target_directories)
		self.target_directories = target_directories
		@current_files = []
		@mtimes = {}
	end

	def watch
		scan_target_directories
		check_modified_times
		if targets_changed?
			@current_files = @new_files
		end
	end

	def targets_changed?
		@targets_changed
	end

	def scan_target_directories
		@new_files = []
		base_dir = Dir.pwd
		self.target_directories.each do |directory|
			@new_files = @new_files + Dir[directory+'/*.*']
		end
		@targets_changed = @new_files.count != @current_files.count
	end

	def check_modified_times
		@current_files.each do |file|
			mtime = File.mtime(file)
			if @mtimes[:file] == nil || @mtimes[:file] != mtime
				@mtimes[:file] = mtime
				@targets_changed = true
			end
		end
	end

end
