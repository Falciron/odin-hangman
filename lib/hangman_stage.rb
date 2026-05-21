# Copyright (c) 2026 Aaron Mattson
# frozen_string_literal: true

# Provides ASCII art depicting the mistake counts in a game of hangman.
module HangmanStage
  STAGE_DEPICTIONS = [
    '     ',

    '  ---',

    "   | \n" \
    "   | \n" \
    "   | \n" \
    '  -+-',

    " |--+ \n" \
    "    | \n" \
    "    | \n" \
    "    | \n" \
    '   -+-',

    " |--+ \n" \
    " o  | \n" \
    "    | \n" \
    "    | \n" \
    '   -+-',

    " |--+ \n" \
    " o  | \n" \
    " |  | \n" \
    "    | \n" \
    '   -+-',

    " |--+ \n" \
    " o  | \n" \
    "`|´ | \n" \
    "    | \n" \
    '   -+-',

    " |--+ \n" \
    " o  | \n" \
    "`|´ | \n" \
    "´ ` | \n" \
    '   -+-'
  ].freeze

  public_constant :STAGE_DEPICTIONS
end
