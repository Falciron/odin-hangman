# Copyright (c) 2026 Aaron Mattson
# frozen_string_literal: true

# Represents a set of utilities for orchestrating a variable-length sequence of games.
class MetagameHelper
  def self.construct_word_list
    word_list = []
    File.readlines(GameRules::WORD_LIST_FILE_NAME).each do |line|
      word_list << line if line.chomp.length in (5..13)
    end
    word_list
  end

  def self.construct_save_game_list
    save_game_list = []
    unless File.exist?(GameRules::SAVE_GAME_DIRECTORY_NAME) && !Dir.empty?(GameRules::SAVE_GAME_DIRECTORY_NAME)
      return save_game_list
    end

    non_default_files = Dir.entries(GameRules::SAVE_GAME_DIRECTORY_NAME).reject { |file| ['.', '..'].include?(file) }
    non_default_files.each do |save_game_file_name|
      save_game_list << save_game_file_name unless ['.', '..'].include?(save_game_file_name)
    end

    save_game_list.sort
  end

  def self.print_save_game_list(save_game_list)
    return if save_game_list.empty?

    puts("The following saved game files exist:\n\n")
    save_game_list.each_with_index do |save_game_file_name, index|
      puts("#{index}: #{save_game_file_name}")
    end
  end

  def self.elicit_save_game_selection(save_game_list)
    return '' if save_game_list.empty?

    loop do
      puts("\nIf you'd like to resume one of the saved games listed above, type its number and then press Enter.")
      print('If you wish to start a new game, instead, just press Enter: ')
      save_game_selection = gets.chomp
      puts
      return save_game_selection if save_game_selection == '' || !save_game_list[save_game_selection.to_i].nil?

      puts("That file number doesn't appear to exist. Please try again.")
    end
    puts("\n")
  end

  def self.load_game_selection(selected_save_game_name)
    save_data = nil
    File.open("save_files/#{selected_save_game_name}", 'r') do |save_file|
      save_data = save_file.read
    end
    Game.from_json(save_data)
  rescue StandardError => e
    puts('An issue occurred while loading the chosen file - proceeding with a new game.')
    puts "Rescued: #{e.message}"
    nil
  end
end
