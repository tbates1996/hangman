class Hangman
	##How the games will be saved 
	require 'yaml'
	#Classes that willed be used by this game class with a 1:1 uses relatationship
	require "./MyFile"
	require "./Display"

	#All the attributes required to play a game of hangman 
	attr_accessor :word, :display,:wrongGuess,:letters

	#Create a game based on how long you want the potential words to be
	def initialize(smallest, largest)
		@wrongGuess = 0
		@letters = []
		@word = MyFile.new("5desk.txt").randomWord(smallest,largest)
		@display = Display.new(@word)
		system 'clear'
		system 'cls'
		
	end	
	#Allows the user to guess a letter and handles errors
	def makeGuess
		#Gets input cleans it up and validates it

		puts "Enter new guess or save and quit with 0"

		letter = gets.chomp.to_s.downcase
		if letter == "0"
			save_game
			exit
		end

		while @letters.include?(letter) #test to see if character when you get internet
			puts "Must enter new letter"
			letter = gets.chomp.downcase
		end
		#Pushes letter into the array of used letters
		@letters << letter
		
		#Update game
		updateGuess(letter)
		system 'clear'
		system 'cls'
		updateScreen

	end

	#Will reduce the ammount of guesses or inform user of correct guess
	def updateGuess(letter)
		if containLetter(letter)
			puts "Correct entry"
		else 
			@wrongGuess = @wrongGuess +1
		end
	end
	#Refreshes the screen showing the updated display
	def updateScreen
		puts "#{5-@wrongGuess} tries remaining"
		@display.printScreen(@letters)
	end

	#Shows if the letter is contained in the current word
	def containLetter letter
		if word.match(letter)
			return true
		else
			return false
		end

	end

	#displays the letters that have been guessed this far
	def lettersUsed
		puts "\nLetters used: #{@letters.join(', ')}"
	end
	#checks for a losing end game status
	def lose?
		return true if @wrongGuess == 5
		return false
	end
	#Test for a win case
	def win?

		count = 0
		i = 0
		while i < @word.size
			count = count +1 if @letters.include?(@word[i])
			i = i + 1
			
		end
		
		return true if count == @word.size 
		return false 
	end

	def save_game 
		save = File.open("game.txt" , 'w+')
		save.write self.to_yaml
		save.close
		
	end

	def load_game
		if File.exists?("game.txt")
			yaml_string = File.read('game.txt')
		else
			puts "No save game"
		end
		game = YAML.load(yaml_string)
		@word = game.word
		@wrongGuess = game.wrongGuess
		@letters = game.letters
		@display = game.display
		system 'clear'
		system 'cls'
		@display.printScreen(@letters)
	end

end

def main

	game = Hangman.new(5,12)
	puts "1. New game"
	puts "2. Load last saved game"
	answer = gets.chomp.to_i
	if answer == 1 
		game = Hangman.new(5,12)
	elsif answer == 2
		game = Hangman.new(5,12)
		game.load_game
	end

	until game.win? || game.lose?
		game.lettersUsed
		game.makeGuess
	end

	if game.lose?
		puts "\nSorry you lost the word was #{game.word}"
		game.display.printDead
		puts ""
	else
		puts "You won!"
	end

end
#Run game with main
#Add menu and save games using files

main 



