class DirectoryWatcher
	attr_accessor :target_directories
	def initialize(target_directories)
		self.target_directories = target_directories
	end
end
