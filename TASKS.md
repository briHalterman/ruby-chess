# Ruby Chess - Project Tasks

## Stage 1: Set Up & Planning
- [x] Create local project directory
- [x] Create TASKS.md
- [x] Initialize git repo and create first commit
- [x] Set up README and .gitignore
- [x] Create basic folder structure
- [x] Set up RSpec with a test runner and spec_helper.rb
- [x] Draft MVP scope
- [x] Define initial classes (Board, Game, Piece, etc.)
- [x] Write first failing test

## Stage 2: Board Functionality
- [x] Initialize an empty 8x8 grid
- [x] Place a piece at a specific position
- [x] Retrieve a piece from a position
- [x] Move a piece from one square to another
- [x] Set up initial chessboard
- [x] Render board in the terminal

## Stage 3: Piece Classes
- [x] Piece base class
- [x] Pawn subclass
- [x] Rook subclass
- [x] Knight subclass
- [x] Bishop subclass
- [x] Queen subclass
- [x] King subclass
- [x] Board Integration

## Stage 4: Game Logic
- [x] Initialize the board
- [x] Place starting pieces on the board
- [x] Set current player to white
- [x] Create player structure
- [x] Prompt player for move input
- [x] Print welcome message and instructions
- [x] Validate move input
- [x] Handle invalid square reference
- [x] Ensure source square has a piece
- [x] Ensure piece belongs to current player
- [x] Ensure destination is a legal move
- [x] Move piece if valid, re-prompt is invalid
- [x] Piece movement logic
- [x] Prevent capturing your own piece
- [x] Replace a captured piece with the moving piece
- [x] Detect & block moving through other pieces (~~rooks~~, ~~bishops~~, ~~queens~~)
- [x] Loop through turns until game ends
- [x] Allow manual exit
- [x] Display board on each turn
- [x] Show current player's turn
- [x] Switch players

## Stage 5: Check & Checkmate
- [x] Detect check
- [x] Prevent self-check
- [x] Detect checkmate
- [x] Declare winner

## Stage 6: Save/Load
- [x] Serialize game state
- [x] Write game state to a file
- [x] Load and deserialize saved game
- [ ] Make saving accessible to players
- [ ] Resume play from saved state

## Stage 7: Final Touches
- [ ] Improve welcome message
- [ ] Error messages for input validation
- [ ] Improve board rendering
- [ ] Polish README and usage instructions
- [ ] Manual playtesting
- [ ] Rubocop