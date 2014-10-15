#1. There is 2 player.
#2. They make a choice either a elelment of [1,2,3,4,5,6,7,8,9]
#3. Compare choices and know win if column and row and cross are the same.
#4. 

class Table

  attr_accessor :deck
  def initialize 
    d = {}
    [1,2,3,4,5,6,7,8,9].each{|e| d[e]=" "}
    @deck = d
  end

    def show_board
    puts "#{deck[1]}|#{deck[2]}|#{deck[3]}"
    puts "=+=+="
    puts "#{deck[4]}|#{deck[5]}|#{deck[6]}"
    puts "=+=+="
    puts "#{deck[7]}|#{deck[8]}|#{deck[9]}"
    end

end

class Player

  attr_accessor :name, :choice
  def initialize (n,c)
    @name =n
    @choice = c
  end

end

class Human < Player

  def choose
    begin
      puts " The availabe choices are #{$choices}"
      puts "Choose a position (from 1 to 9) to place a piece O:"
      choice = gets.chomp.to_i
    end until $choices.include?(choice)
    self.choice = choice
    self.table.deck[choice] = "O"
    $choices.delete(choice)
  end

  def to_s
  puts "#{name} chose #{choice} "
  end

end

class Computer < Player
  def choose
    self.choice = $choices.sample
    self.table.deck[choice] = "X"
    $choices.delete(self.choice) 
  end
  
  def to_s
  "#{name} chose #{choice}"
  end
end

class Game
  $choices = [1,2,3,4,5,6,7,8,9]
  table = Table.new
  attr_accessor :player, :computer

  def initialize 
      @player = Human.new("Bob",nil)
      @computer = Computer.new("Lenovo",nil)
  end

  def human_won?(table)   

    if (table.deck[1]== "O")&&(table.deck[2]=="O")&&(table.deck[3]== "O")
    return "You won!"
    elsif (table.deck[4]== "O")&&(table.deck[5]=="O")&&(table.deck[6]== "O")
    return "You won!"
    elsif (table.deck[7]== "O")&&(table.deck[8]=="O")&&(table.deck[9]== "O")
    return "You won!"
    elsif (table.deck[1]== "O")&&(table.deck[4]=="O")&&(table.deck[7]== "O")
    return "You won!"
    elsif (table.deck[2]== "O")&&(table.deck[5]=="O")&&(table.deck[8]== "O")
    return "You won!"
    elsif (table.deck[3]== "O")&&(table.deck[6]=="O")&&(table.deck[9]== "O")
    return "You won!"
    elsif (table.deck[1]== "O")&&(table.deck[5]=="O")&&(table.deck[9]== "O")
    return "You won!"
    elsif (table.deck[3]== "O")&&(table.deck[5]=="O")&&(table.deck[7]== "O")
    return "You won!"
    end  
  end

  def computer_won?(table)   

    if (table.deck[1]== "X")&&(table.deck[2]=="X")&&(table.deck[3]== "X")
    return "Computer won!"
    elsif (table.deck[4]== "X")&&(table.deck[5]=="X")&&(table.deck[6]== "X")
    return "Computer won!"
    elsif (table.deck[7]== "X")&&(table.deck[8]=="X")&&(table.deck[9]== "X")
    return "Computer won!"
    elsif (table.deck[1]== "X")&&(table.deck[4]=="X")&&(table.deck[7]== "X")
    return "Computer won!"
    elsif (table.deck[2]== "X")&&(table.deck[5]=="X")&&(table.deck[8]== "X")
    return "Computer won!"
    elsif (table.deck[3]== "X")&&(table.deck[6]=="X")&&(table.deck[9]== "X")
    return "Computer won!"
    elsif (table.deck[1]== "X")&&(table.deck[5]=="X")&&(table.deck[9]== "X")
    return "Computer won!"
    elsif (table.deck[3]== "X")&&(table.deck[5]=="X")&&(table.deck[7]== "X")
    return "Computer won!"
    end  
  end

  def show_result
    if human_won? 
      puts human_won?
    elsif computer_won?
      puts computer_won?
    elsif $choices.empty?
      puts "It is a tie!"
    end
  end

  def run 
    begin 
      $choices = [1,2,3,4,5,6,7,8,9]
      table = Table.new
      loop do
      system 'clear'
      table.show_board
      player.choose
      break if human_won?(table) 
      break if $choices.empty?
      computer.choose
      break if computer_won?(table) 
      end
      system 'clear'
      table.show_board
      show_result

      begin 
        puts "Play again?(Y/N)"
        again = gets.chomp.downcase
      end until again=="y"||again=="n"
    end until again == "n"  

    end 
end

Game.new.run


