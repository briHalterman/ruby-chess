# main.rb
# Entry point for Ruby Chess game
require_relative './lib/game'

def list_saved_games
  Dir.mkdir('saves') unless Dir.exist?('saves')
  saves = Dir.entries('saves').select { |f| f.end_with?('.yaml') }
  saves.sort
end

def prompt_user_choice
  puts "Welcome to Ruby Chess!"
  puts "Type 'new' to start a new game or 'load' to continue a saved game:"
  print "> "
  gets.chomp.downcase
end

def prompt_save_selection(saves)
  puts "\nSaved files:"
  saves.each_with_index do |file, index|
    puts "#{index + 1}: #{file}"
  end
  puts "Enter the number of the saved file load:"
  print "> "
  choice = gets.chomp.to_i
  saves[choice - 1]
end

loop do
  case prompt_user_choice
  when 'new'
    Game.new.play
    break
  when 'load'
    saves = list_saved_games
    if saves.empty?
      puts "No saved games found."
    else
      selected_file = prompt_save_selection(saves)
      loaded_game = Game.load_game("saves/#{selected_file}")
      puts "\nLoaded: #{selected_file}. Pieces reset to last position...\n\n"
      loaded_game.play
      break
    end
  else
    puts "Invalid choice. Please try again.\n\n"
  end
end