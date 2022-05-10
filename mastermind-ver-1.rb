=begin
Project: Mastermind
Objectives: Implement the Mastermind game logic.

Necessities:
1. split() to split the input string.
2. Index loop to map the index and value of 
   both the initial code and guesses.
3. include() to check whether the characters in the guess
   are in the initial code.

Logic:
1. The computer will randomly create a code.
2. A player have to guess the code in ten rounds.
3. Each round, the player will provide code input.
4. If there is a character in the input code that is in the
   the initial code and at the same place, return a x.
5. If there is a character in the input code that is in the
   the initial code but not at the same place, return a y.
=end

def create_random_code
    code = Array.new()
    number_array = [0,1,2,3,4,5,6,7,8,9]
    4.times do
         chosen_number = number_array.sample
         code.push(chosen_number)
         number_array.delete(chosen_number)
    end
    code 
end

def check_correct_code(input_code, initial_code)
   puts input_code
   puts initial_code
   hint =  Array.new()
   input_code.each_with_index do |value, index|
      puts value
      puts initial_code[index]
      if initial_code[index] == value then
         hint.push("x")         
      elsif initial_code.include?(value.to_i)
         hint.push("y")
      else
         hint.push("z")
      end
   end
   return hint
end

initial_code = create_random_code
puts initial_code
turns = 0
while turns < 10
   input_code = gets.chomp
   guessed_code = input_code.split('').map!{|value| 
      value.to_i
   }

   if initial_code != guessed_code 
      puts check_correct_code(guessed_code, initial_code)
   else
      puts 'You have guessed the correct code.'
      break
   end
   turns += 1
end