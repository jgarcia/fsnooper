class FSnooper
	
	attr_accessor :commands, :target_directories
	
	def initialize(args)
		self.commands = ArgumentsParser.parse("-c", args)
		self.target_directories = ArgumentsParser.parse("-d", args)
		@directory_watcher = DirectoryWatcher.new self.target_directories
	end

	def run
		@directory_watcher.watch
		if @directory_watcher.targets_changed?
			execute_commands
		end
	end
	
	def execute_commands
		self.commands.each do |command|
			#system(command)
		end
	end

end
