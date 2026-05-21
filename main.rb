# Copyright (c) 2026 Aaron Mattson
# frozen_string_literal: true

require_relative 'lib/game'

word_list = []
File.readlines('google-10000-english-no-swears.txt').each do |line|
  word_list << line if line.chomp.length in (5..13)
end

loop do
  Game.new(word_list).play_game
  puts('Press Enter to play a new game or press Ctrl+C to quit.')
  gets
rescue Interrupt
  exit
end
