# Copyright (c) 2026 Aaron Mattson
# frozen_string_literal: true

require_relative 'game_rules'

# Represents the (human) hangman player trying to guess the secret word.
class Player
  # Elicits a guess at a letter of the word from the player via terminal input.
  def self.make_guess
    loop do
      print("Enter a single letter (ex. 'a') to make a guess or enter 'save' to save and quit: ")
      letter = gets.chomp
      return letter if letter in ::GameRules::LETTER_SPACE || letter == 'save'

      puts('That was an invalid entry, but it will not be counted against you. Try again.')
    end
  end

  def self.select_save_file_name
    print_save_instructions
    gets.chomp
  end

  private

  def self.print_save_instructions
    print(
      'Type the name for your save file, then press Enter to save, ' \
      'or press Enter immediately to return to your game: '
    )
  end

  private_class_method :print_save_instructions
end
