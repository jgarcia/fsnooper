class FSnooper
	
	attr_accessor :commands, :target_directories
	
	def initialize(args)
		self.commands = ArgumentsParser.parse("-c", args)
		self.target_directories = ArgumentsParser.parse("-d", args)
		directory_watcher = DirectoryWatcher.new self.target_directories
	end

end
