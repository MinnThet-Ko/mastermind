=begin
Project: Mastermind(Player gives the code.)
Objective: Implement the mastermind game where the player gives the code and the computer have
           to guess the correct code.

Logic:
1. The player gives the code with numbers between 1-6 and contains no duplicates.
2. The computer gives the guess code.
3. The player gives back feedback.
4. Loop through the feedback.
5. If the feedback is 'x', keep the number at the same index.
6. If the feedback is 'y', switch the number to a different index.
7. If the feedback is 'z', switch an another number.
8. Repeat from step 2 to 7 untill the hint is all 'x' or you have played 10 rounds.
=end

#number pool to guess code
$number_array = [0,1,2,3,4,5,6]

#function to create random code
def create_random_code
    code = Array.new()
    4.times do
        chosen_number = $number_array.sample
        code.push(chosen_number)
        $number_array.delete(chosen_number)
    end
    code 
end

#function to create a random number for the guessed_code
def get_random_number(excluded_number)
    chosen_number = $number_array.sample
    $number_array.delete(chosen_number)
    return chosen_number
end

#function to swap the guessed_code
def swap_code(guessed_code, y_indexes)
    index_array_length =  y_indexes.length
    i = 0
    while i < index_array_length-1
        placeholder = guessed_code[y_indexes[i]]
        guessed_code[y_indexes[i]] = guessed_code[y_indexes[i+1]]
        guessed_code[y_indexes[i+1]] = placeholder
        i+=1
    end
    return guessed_code
end
#ask the user to give code
puts 'Enter a code with numbers between 1-6 and contains no duplicates.'
given_code = gets.chomp.split('')

#play 10 truns
turns = 1

#create an initial guess
guessed_code = create_random_code
while turns < 10
    #display the guessed_code
    puts "Is the code #{guessed_code}?"
    
    #get feedback from the player
    feedback = gets.chomp.split('')
    if feedback.all? {|hint| hint == 'x'} then
        puts "You have guessed the correct code."
        $number_array = [0,1,2,3,4,5,6]
        break
    end
    #create an array for making
    y_indexes = Array.new()

    #loop through the feedback for 'x' and 'z'
    feedback.each_with_index do |hint, index|
        #If the hint is 'z', replace it with a new number.
        if hint == 'z'
            guessed_code[index] =  get_random_number(guessed_code[index])
        #If the hint is 'y', mark its index.
        elsif hint == 'y'
            y_indexes.push(index)
        end
    end
    guessed_code = swap_code(guessed_code, y_indexes) if y_indexes.length > 1
    turns += 1
end