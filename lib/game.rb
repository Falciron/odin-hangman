# Copyright (c) 2026 Aaron Mattson
# frozen_string_literal: true

require 'fileutils'
require_relative 'hangman_stage'
require_relative 'player'

# Represents a single game of Hangman
class Game
  def initialize(word_list)
    @secret_word = word_list.sample.chomp
    @currently_solved_word = '_' * @secret_word.length
    @letters_guessed = []
    @remaining_mistakes = 7
  end

  # Starts the game of hangman, using the initialized values.
  def play_game
    print_intro
    while @remaining_mistakes.positive?
      letter = ::Player.make_guess
      if letter == 'save'
        save_and_quit
      else
        process_letter(letter)
        return if game_over?
      end
    end
  end

  private

  def print_intro
    puts("The word you are trying to guess is #{@secret_word.length} letters in length. ")
  end

  def game_over?
    if @currently_solved_word == @secret_word
      puts('Congratulations, you guessed the secret word!')
      true
    elsif @remaining_mistakes.zero?
      puts("Unfortunately, you ran out of mistakes before guessing the secret word (#{@secret_word}).")
      true
    else
      false
    end
  end

  def save_and_quit
    save_file_name = ::Player.select_save_file_name
    return if save_file_name == ''

    save_game_data(save_file_name)
  end

  def save_game_data(save_file_name)
    save_game_directory = 'save_files'
    FileUtils.mkdir_p(save_game_directory)
    File.open("#{save_game_directory}/#{save_file_name}", 'w+') do |file|
      file.puts(Marshal.dump(self))
    end
    exit
  end

  def process_letter(letter)
    evaluate_guess(letter)
    update_currently_solved_word
    print_current_status
  end

  def evaluate_guess(letter)
    if @letters_guessed.include?(letter)
      puts("\nYou've guessed that letter already, but it will not be counted against you. Try again.")
    elsif @secret_word.include?(letter)
      puts("\nGreat guess! That letter is present. ")
      @letters_guessed << letter
    else
      puts("\nBad guess. That letter is not present. ")
      @letters_guessed << letter
      @remaining_mistakes -= 1
    end
  end

  def update_currently_solved_word
    @currently_solved_word = ''
    @secret_word.length.times do |letter_index|
      current_letter = @secret_word[letter_index]
      @currently_solved_word =
        if @letters_guessed.include?(current_letter)
          @currently_solved_word + current_letter
        else
          "#{@currently_solved_word}_"
        end
    end
  end

  def print_current_status
    print_clues if @currently_solved_word != @secret_word
    print("\n#{::HangmanStage::STAGE_DEPICTIONS[7 - @remaining_mistakes]}")
    puts(" Solved Letters: #{@currently_solved_word.chars.join(' ')}\n\n")
  end

  def print_clues
    puts("You have #{@remaining_mistakes} remaining mistake(s) to identify the secret word.")
    puts("Letters guessed: #{@letters_guessed.sort.join}")
  end
end
