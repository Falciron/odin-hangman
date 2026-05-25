# Copyright (c) 2026 Aaron Mattson
# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/game_rules'
require_relative 'lib/metagame_helper'

word_list = MetagameHelper.construct_word_list

save_game_list = MetagameHelper.construct_save_game_list
MetagameHelper.print_save_game_list(save_game_list)
save_game_selection = MetagameHelper.elicit_save_game_selection(save_game_list)

next_game = nil
if save_game_selection != ''
  selected_save_game_name = save_game_list[save_game_selection.to_i]
  next_game = MetagameHelper.load_game_selection(selected_save_game_name)
end

loop do
  if next_game.nil?
    secret_word = word_list.sample.chomp
    next_game = Game.new(secret_word, '_' * secret_word.length)
  end

  next_game.play_game
  next_game = nil
  puts('Press Enter to play a new game or press Ctrl+C to quit.')
  gets
rescue Interrupt
  exit
end
