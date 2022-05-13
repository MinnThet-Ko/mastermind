class Computer 

    @@number_array = [0,1,2,3,4,5,6]

    def renew_number_array 
        @@number_array = [0,1,2,3,4,5,6]
    end
    #methods for the computer if it is a code maker
    
    #method to create random code
    def create_random_code
        code = Array.new()
        4.times do
             chosen_number = @@number_array.sample
             code.push(chosen_number)
             @@number_array.delete(chosen_number)
        end
        code 
    end

    #method to check teh guessed code
    def check_correct_code(input_code, initial_code)
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
        return hint.join('')
    end

    #methods for the computer if it is a code hacker
    
    #function to create a random number for the guessed_code
    def get_random_number(excluded_number)
        chosen_number = @@number_array.sample
        @@number_array.delete(chosen_number)
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

    #play as a code maker
    def play_as_code_maker
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
    end

    #play as code hacker
    def play_as_code_hacker
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
    end
end

computer = Computer.new

keep_playing =  true
while keep_playing
    puts 'Will you play as \n 1. a code maker \n 2. a code hacker?'
    game_type =  gets.chomp.to_i
    if game_type == 1
        computer.play_as_code_hacker
    elsif game_type == 2
        computer.play_as_code_maker
    end
    computer.renew_number_array
    puts 'Will you keep playing?[Y/N]'
    decision =  gets.chomp
    if decision.upcase == 'Y'
        keep_playing = true
    elsif decision.upcase == 'N'
        keep_playing = false
    end
end