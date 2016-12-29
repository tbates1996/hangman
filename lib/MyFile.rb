class MyFile

	#this variable will handle the file and all its operations
	attr_accessor :handle
	
	#opens the file by the file name and gets it ready to be read
	def initialize myFileName
		@handle = File.new(myFileName, "r")
	end
	#closes the file once all opperations on it are completed
	def finished
		@handle.close
	end
	#Takes the word list and creates an array based on word length parameters
	def to_a(smallest, largest)
		wordList = []
		@handle.each do |line|
			length = line.chomp.size
			if length >= smallest && length <= largest
				wordList << line
			end
		end
		wordList
	end
	#generates a random number in the word set and returns a random word
	def randomWord(smallest, largest)
		list = to_a(smallest,largest)
		number = rand(list.size) + 1
		list[number].downcase.chomp
	end
end

