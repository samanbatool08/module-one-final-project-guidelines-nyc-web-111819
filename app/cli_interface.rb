@prompt = TTY::Prompt.new

def clean
    system "clear"
end

class CLI
    def welcome
        puts "Welcome!"
        # sleep(1)
        login_signup
        # clean
    end

    def login_signup
        puts 'Returning user? type "yes". New user? type "new"' 
        user_input = gets.chomp
        if user_input == "new"
            puts "Create username"
            input_username = gets.chomp
            @@user = User.create(username: input_username)
            # @prompt.mask ("Create password")
            main_menu_new_user
        elsif user_input == "yes"
            puts "Enter username"
            input_existinguser = gets.chomp
            @@user = User.find_by(username: input_existinguser)
            # @prompt.mask ("Enter password")
            if @@user == nil
                puts "We do not recognize that username try again"
                login_signup 
            else
                main_menu_existing_user
            end  
        end
    end

    def main_menu_existing_user
        clean
        puts ' 
        Welcome back!
        What would you like to do?
            1: List of restaurants you have reviewed
            2: Write a new review
            3: Update a previous review
            4: Delete a previous review
            5: Choose a restaurant
            6: Log out'
            # response = @prompt.select("What would you like to do?", ["1: List of restaurants you have reviewed", "2: Write a new review", "3: Update a previous review"])
        case gets.chomp
            when "1"
                list_of_restaurants
                # sleep(1)
                after_list_of_restaurants
            when "2"
                new_review
                after_review
            when "3"
                update_review
                after_updated_review
            when "4"
                delete_review
                after_deletion
            when "5"
                puts "Here is a list of all the restaurants and their cuisines.."
                # sleep(2)
                all_restaurants
                # sleep(2)
                puts "Would you like to review a restaurant on this list?"
                user_input = gets.chomp
            if user_input == "yes"
                puts "Great, which restaurant?"
                input_restaurant = gets.chomp
                new_restaurant = Restaurant.find_or_create_by(name: input_restaurant)
                puts "Begin writing your review for #{new_restaurant.name} here..."
                input_review = gets.chomp
                Review.create(user_id: @@user.id, restaurant_id: new_restaurant.id, content: input_review)
                after_review
            elsif user_input == "no"
                puts "Okay, tell us the name of your restaurant and we'll add to our list!"
                input_restaurant = gets.chomp
                new_restaurant = Restaurant.find_or_create_by(name: input_restaurant)
                puts "Begin writing your review here..."
                input_review = gets.chomp
                Review.create(user_id: @@user.id, restaurant_id: new_restaurant.id, content: input_review)
                after_review
            end
            when "6"
                    puts "Thanks for using our Restaurant Review App. See you soon!"
                    
        end
    end

    def list_of_restaurants
        puts "Here are the restaurants that you have reviewed so far.."
                @@user.reviews.each do |review|
                    puts review.restaurant.name
                    puts review.content
                end
            end

    def after_list_of_restaurants
        puts 'What would you like to do next?
            1: Write a new review 
            2: Update a review
            3: Go back to main menu'
        case gets.chomp
            when "1"
                new_review
                after_review
            when "2"
                update_review
                after_updated_review
            when "3"
                main_menu_existing_user
        end
    end

    def update_review
        puts "Sure, which review would you like to update?"
        # sleep(1)
        @@user.reviews.each do |review|
            puts review.restaurant.name
            puts review.content
        end
        restaurant_name = gets.chomp
        chosen_restaurant = Restaurant.find_by(name: restaurant_name)
        puts "Okay, write your updated review for #{chosen_restaurant.name} here.."
        updated_review = gets.chomp
        found_review = @@user.reviews.find {|review| review.restaurant_id == chosen_restaurant.id}
        found_review.update(content: updated_review) 
        @@user.save
        @@user.reload
        # can use a shorter method to update
        # first_user = User.first 
        # first_user.update(username: "value")

    end

    def after_updated_review
        puts "Your review has been updated! Type 'return' to go back to the main menu or 'exit' to leave"
                    user_input = gets.chomp
                    if user_input == "return"
                        main_menu_existing_user
                    elsif user_input == "exit"
                        puts "Thank you for using our one of a kind Restaurant Review App!"
                    end
    end

        
    def new_review
        puts "What restaurant would you like to review?"
                    input_restaurant = gets.chomp
                    new_restaurant = Restaurant.find_or_create_by(name: input_restaurant)
                    puts "Great! Begin writing your review for #{new_restaurant.name} here..."
                    input_review = gets.chomp
                    Review.create(user_id: @@user.id, restaurant_id: new_restaurant.id, content: input_review)
                    @@user.save
                    @@user.reload
    end

    def after_review
        puts "Thank you for writing a review! Type 'return' to go back to the main menu or 'exit' to leave"
                    user_input = gets.chomp
                    if user_input == "return"
                        main_menu_existing_user
                    elsif user_input == "exit"
                        puts "Thank you for using our one of a kind Restaurant Review App!"
                    end
    end

    def delete_review
        puts "Which review would you like to delete?"
        # sleep(1)
        @@user.reviews.each do |review|
        puts review.restaurant.name
        puts review.content
    end
    restaurant_name = gets.chomp
        chosen_restaurant = Restaurant.find_by(name: restaurant_name)
        puts "Okay, deleting your review for #{chosen_restaurant.name}.."
        found_review = @@user.reviews.find {|review| review.restaurant_id == chosen_restaurant.id}
        found_review.destroy
        @@user.save
        @@user.reload
    end

    def after_deletion
            puts "Your review has been deleted! Type 'return' to go back to the main menu or 'exit' to leave"
                        user_input = gets.chomp
                        if user_input == "return"
                            main_menu_existing_user
                        elsif user_input == "exit"
                            puts "Thank you for using our one of a kind Restaurant Review App!"
                        end
        end



    def all_restaurants
        Restaurant.all.each do |restaurant|
            puts restaurant.name
            puts restaurant.cuisine
        end
    end


    def main_menu_new_user
        # clean
        puts 'Thank you for joining! Lets get started!
        What would you like to do?
            1: Write my first review!
            2: Choose a restaurant
            3: Log out'
        case gets.chomp
            when "1"
                new_review
                after_review
            when "2"
                puts "Here is a list of all the restaurants and their cuisines.."
                    sleep(2)
                    all_restaurants
                    sleep(2)
                    puts "Would you like to review a restaurant on this list?"
                    user_input = gets.chomp
                    if user_input == "yes"
                        puts "Great, which restaurant?"
                        input_restaurant = gets.chomp
                        new_restaurant = Restaurant.find_or_create_by(name: input_restaurant)
                        puts "Begin writing your review for #{new_restaurant.name} here..."
                        input_review = gets.chomp
                        Review.create(user_id: @@user.id, restaurant_id: new_restaurant.id, content: input_review)
                        after_review
                    elsif user_input == "no"
                        puts "Okay, tell us the name of your restaurant and we'll add to our list!"
                        input_restaurant = gets.chomp
                        new_restaurant = Restaurant.find_or_create_by(name: input_restaurant)
                        puts "Begin writing you're review here..."
                        input_review = gets.chomp
                        Review.create(user_id: @@user.id, restaurant_id: new_restaurant.id, content: input_review)
                        after_review
                    end
            when "3"
                puts "Thanks for using our Restaurant Review App. See you soon!"
            
        end
    end
end  
    



 

# def main_menu 
#     'LIst of a bunch of options'
# end 

