class Display
	
	#This is the word that the board is working with
	attr_accessor :word
	
	#Print the hangman if the player loses
	#Impliment dynamic hangman after every move 
	def printDead
		print %q{   ______
   |    |
   |    O
   |   /|\
   |    |
   |   / \
___|___}
	end
	#Initializes the board for the word passed 
	def initialize word
		@word = word
	end
	#prints the current board state
	def printScreen guesses
		for i in 0...@word.size
			if guesses.include?(word[i])
				print "#{word[i]} "
			else 
				print "_ "
			end
		end
	end

end



