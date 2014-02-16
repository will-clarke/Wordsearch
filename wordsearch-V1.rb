SIZE = 6
HIDDEN_WORDS = %w{ dog cool fat monkey }.map {|i| i.upcase}
grid = Array.new(SIZE+1){Array.new(SIZE+1){' - '}}


def random_letters
  ('A'..'Z').to_a[rand(26)]
end


def random_direction
  direction = [*-1..1].product([*-1..1])[rand(9)]
  if direction == [0,0]
    direction = [1,0]
  end
  direction
end

def add_to_grid( x, y, grid )
  x.each do |x_|
    y.each do |y_|
      grid[y_][x_] = ' X '
    end
  end
end

def direction_to_range (x_or_y_direction, length, size = SIZE)
  # start_ = x_or_y_direction < 0 ? length.abs  : 0
  start_ = x_or_y_direction < 0 ? length.abs-1  : 0

  # start_ = x_or_y_direction < 0 ? size - (length.abs)  : 0
  end_ = x_or_y_direction > 0 ? size - (length.abs-1) : size
  (start_..end_)
end


def find_starting_positions( word, direction, size = SIZE )

  ranges_exploded_to_array = []

  x_direction = direction[0]
  y_direction = direction[1]
  length = word.length

  x_range = direction_to_range x_direction, length
  y_range = direction_to_range y_direction, length

  x_range.each do |x|
    y_range.each do |y|
      ranges_exploded_to_array << [x, y]
    end
  end

  ranges_exploded_to_array
end

def plot_to_grid ( starting_positions,size = SIZE)
  grid = Array.new(SIZE+1){Array.new(SIZE+1){' - '}}
  starting_positions.each do |position|
    grid[position[1]][position[0]] = ' X '
  end
  grid.reverse.each {|i| p i}
end

def plot_words( starting_positions, direction, word, grid, size = SIZE )

  finished = nil
  finished_count = 0
  while !finished do
      start = starting_positions[rand(starting_positions.count)]
      test_start = start.dup

      test_array = []

      word.chars.each do |character|
        # 			p "test_start-grid = #{grid[test_start[1]][test_start[0]]}"
        # #
        # 		# ink in if okay:
        test_array << grid[test_start[1]][test_start[0]]

        test_start[0] += direction[0]
        test_start[1] += direction[1]

      end



      regex_of_potential_next_places = Regexp.new(test_array.join.gsub(' ','').gsub('-','.'))
      if regex_of_potential_next_places =~ word
        # p 'yes...'
        finished = 1
      else
        # p 'NO...'
        finished_count += 1
        if finished_count > 1000
          p 'Soz. Please try again... :('
          finished = 1
        end

      end
    end

    # if

    # if test_array.gsub(' - ',)

    # end


    # IF OKAY:
    word.chars.each do |character|
      # ink in if okay:
      grid[start[1]][start[0]] = " " + character + " "

      start[0] += direction[0]
      start[1] += direction[1]
    end

    # grid.reverse.each{|i| p i}
  end

  HIDDEN_WORDS.each do |word|

    direction = random_direction
    x_direction = direction[0]
    y_direction = direction[1]

    starting_positions = find_starting_positions( word , direction )

    plot_words( starting_positions, direction, word, grid)

    # plot_to_grid( starting_positions )
  end

  def print_wordsearch (grid )
tmp = []
    grid.each do |line|

      line.each do |character|

      	character.gsub!('-',('A'..'Z')
      		.to_a[rand(26)])

      end

  tmp << line.join

    end
    tmp.reverse.each{|i| p i}


  end

  # grid.reverse.each{|i| p i}
  # p ""
  # p ""
  print_wordsearch (grid)
