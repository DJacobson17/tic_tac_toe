class Player # rubocop:disable Style/Documentation
  attr_accessor :name, :marker, :score

  def initialize(player_number)
    give_name(player_number)
    give_marker(player_number)
    @score = 0
  end
  @@other_marker = '' # rubocop:disable Style/ClassVars

  private

  def give_name(player_number)
    puts "Welcome to the game player #{player_number} what's your name?"
    @name = gets.chomp.upcase
  end

  def give_marker(_player_number)
    validate_marker = false
    until validate_marker
      puts 'Please choose a letter to represnt you.'
      puts "It cannot be #{@@other_marker}." if @@other_marker != ''
      @marker = gets.chomp.upcase
      if @marker =~ /^[A-Z]\b/ && @marker != @@other_marker
        @@other_marker = @marker
        validate_marker = true
      else
        puts 'Invalid selection.  Please choose again.'
      end
    end
  end
end
