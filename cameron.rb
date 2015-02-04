#adventure.rb
puts "Once upon a time, a viscious dragon was chasing you. Oh no! Being chased by a dragon!"
puts "Not to fear. You are a conscious human being. You got this."
puts "Options:"
puts "1 - Hide in a cave"
puts "2 - Climb a tree"

input = gets.chomp.to_i

if input == 1
  puts "You chose to hide in a cave. The dragon finds you and asks if you'd like to play a game of Scrabble. Maybe not not so vicious after all- crisis averted"
elsif input == 2
  puts "You climb a tree. The dragon can't find you."
  puts "But all of a sudden!"
  puts "There is an angry monkey getting ready to attack you for storming into their lair!"
  puts "Do you want to climb down the tree or face the monkey?"
  puts "1 - get out of the tree"
  puts "2 - face the ape"
  input2 = gets.chomp.to_i
  if inputs2 = 2
    puts "let's get ready to kick some monkey butt!"
  else
    puts "Hurry up and scamper down the tree you ninny!"
  end
else
  puts "That's not a valid option. Please try again"
end
