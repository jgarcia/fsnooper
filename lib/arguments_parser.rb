module ArgumentsParser
	
	def self.parse(flag, args)
		flag_index = args.index(flag)
		index = flag_index + 1
		result = []
		until index > args.count-1 || args[index].include?("-") do
			result << args[index]
			index+=1
		end
		result
	end

end
