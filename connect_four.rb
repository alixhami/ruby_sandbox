class Game
  def initialize
    @board = [
      ["-","-","-","-","-","-","-"],
      ["-","-","-","-","-","-","-"],
      ["-","-","-","-","-","-","-"],
      ["-","-","-","-","-","-","-"],
      ["-","-","-","-","-","-","-"],
      ["-","-","-","-","-","-","-"]
    ]
    @board_width = @board[0].length
    @board_height = @board.length
    @plays_remaining = @board_width * @board_height

    @player_1 = {
      id: 1,
      character: "X"
    }
    @player_2 = {
      id: 2,
      character: "O"
    }
    @active_player = @player_1
    @inactive_player = @player_2
  end

  def define_players
    [@player_1, @player_2].each do |player|

      print "Player #{player[:id]}, which piece would you like to be? > "
      player[:character] = gets.chomp
      until player[:character].length == 1
        print "Please input only one character as your game piece > "
        player[:character] = gets.chomp
      end

      print "Would you like to be a computer? > "
      response = gets.chomp.downcase
      while player[:is_computer].nil?
        if response == "yes" || response == "y"
          player[:is_computer] = true
        elsif response == "no" || response == "n"
          player[:is_computer] = false
        else
          print "Please type 'yes' or 'no' > "
          response = gets.chomp.downcase
        end
      end

      puts
    end
  end

  def switch_players
    @active_player, @inactive_player = @inactive_player, @active_player
  end

  def get_column_number

    if @active_player[:is_computer]
      column = rand(0...7)
    else
      column = ""
      until (1..7) === column
        print "Which column? > "
        column = gets.chomp.to_i
      end
    end
    column
  end

  def place_tile
    column = get_column_number
    row = @board_height - 1
    loop do
      if @board[row][column] == "-"
        @board[row][column] = @active_player[:character]
        @plays_remaining -= 1
        break
      else
        row -= 1
        if row == -1
          puts "The selected column is full. Please try again."
          place_tile
          break
        end
      end
    end
  end

  def print_board
    @board.each do |row|
      row.each do |character|
        print character, " "
      end
      puts
    end
    # Print column numbers at the bottom
    (1..@board_width).each { |num| print "#{num} "}
    puts
    puts
  end

  def winner
    puts "Player #{@active_player[:id]} wins!"
    exit
  end

  def tie
    puts "It's a tie! GAME OVER"
    exit
  end

  def check_for_win
    winning_combo = @active_player[:character] * 4
    win_zones = []

    # Add rows to win zones
    @board.each do |row|
      win_zones << row.join
      # winner if row.join.include? winning_combo
    end

    # Add columns to win zones
    @board_width.times do |col|
      column = ""
      @board_height.times do |row|
        column << @board[row][col]
      end
      win_zones << column
    end

    # Add diagonals to win zones
    current_board = @board

    2.times do |round|

      # Reverse board for second round
      current_board = @board.map { |row| row.reverse } if round == 1

      # Starting at top left of board
      (0..@board_width-4).each do |start|
        diagonal = ""
        latitude = start
        @board_height.times do |i|
          diagonal << current_board[i][latitude] if latitude < @board_width
          latitude += 1
        end
        win_zones << diagonal
      end

      # Starting at top left side of board
      (1..@board_height-4).each do |start|
        diagonal = ""
        longitude = start
        @board_height.times do |i|
          diagonal << current_board[longitude][i] if longitude < @board_height
          longitude += 1
        end
        win_zones << diagonal
      end

    end

    win_zones.each do |zone|
      winner if zone.include? winning_combo
    end

  end

  def play
    define_players
    print_board
    loop do
      puts "Player #{@active_player[:id]} GO!"
      place_tile
      print_board
      check_for_win
      tie if @plays_remaining == 0
      switch_players
    end
  end

end

game1 = Game.new
game1.play
