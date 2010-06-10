module ArgumentsParser
	
	def self.parse(flag, args)
		flag_index = args.index(flag)
		index = flag_index + 1
		result = []
		while index < args.count and !args[index].start_with?('-')
			result << args[index]
			index+=1
		end
		result
	end

end
