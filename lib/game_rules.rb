# Copyright (c) 2026 Aaron Mattson
# frozen_string_literal: true

# Includes constants that define hangman gameplay rules and settings.
module GameRules
  LETTER_SPACE = ('a'..'z')
  SAVE_GAME_DIRECTORY_NAME = 'save_files'
  WORD_LIST_FILE_NAME = 'google-10000-english-no-swears.txt'

  public_constant :LETTER_SPACE, :SAVE_GAME_DIRECTORY_NAME
end
