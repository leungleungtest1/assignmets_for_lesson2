#Purpose: play the game paper rock scissors
#1. gets name of player
#2. player makes a choice
#3. computer makes a choice
#4. compare the choices and get a result
#5. encore



# create a class of Player, kind of state: string only
class Player
  attr_accessor :name, :p_c
  def initialize (n=nil, c=nil)
    @name = n
    @p_c = c
  end
end

# create a class of Player, kind of state: string only 
class Computer
  attr_accessor :name,:m_c
  def initialize (n = "computer",c=nil)
    @name = n
    @m_c = c
  end
end

# create a method of get_name
# input: string, output: string
module GetNameAble
  def get_name  
    while  player.name ==""
    puts "What is your name?"
    player.name= gets.chomp
    end
  end
end

# create a method of choose
# input: string, output: string
module ChooseAble
  def choose 
    while  player.p_c !="p"&& player.p_c !="r"&& player.p_c != "s"
    puts "choose one. (P/R/S)"
    player.p_c = gets.chomp.downcase 
    end
  end
end

# create a method of choose
# input: string, output: string
module ComputerChooseAble
  def computer_choose 
    @computer.m_c = ['p','r','s'].sample 
  end
end

#create a method of check a result
#input: string, output: puts string
module WhoWonAble
  def who_won?(p_c,m_c)
    if p_c == m_c && p_c!= nil
      puts "It is a tie!"
    elsif (p_c=="p" && m_c =="r")||(p_c=="r" && m_c=="s")||(p_c=="s" && m_c=="p")
      puts "#{winning_msg(p_c, m_c)}"
      puts "You won!"
    else
      puts "#{winning_msg(p_c, m_c)}"
      puts "Computer won!"
    end
  end
end

#create a method of send a message
#input "string", output: string
module WinMsgable
  def winning_msg(p_c, m_c)
    if p_c =="p" && m_c == "r"
      "Paper wraps Rock."
    elsif p_c =="r" && m_c == "s"
      "Rock smashs Scissors."
    elsif p_c == "s" && m_c =="p"
      "Scissors cuts Paper."
    elsif m_c =="p" && p_c == "r"
      "Paper wraps Rock."
    elsif m_c =="r" && p_c == "s"
      "Rock smashs Scissors."
    elsif m_c == "s" && p_c =="p"
      "Scissors cuts Paper." 
    else
      nil
    end
  end
end

class Game
  include GetNameAble, ChooseAble, ComputerChooseAble, WinMsgable ,WhoWonAble
  attr_accessor :player, :computer
  def initialize
    @player = Player.new("",nil)
    @computer = Computer.new("computer",nil)
  end
  def run
    get_name
    answer = "y"
    while answer == "y"
      @player.p_c = nil
      choose
      computer_choose
      puts "You pick #{@player.p_c} and computer picks #{@computer.m_c}"
      who_won?(@player.p_c, @computer.m_c)
    puts " Play again?(Y/N)"
    answer = gets.chomp.downcase  
    end
    puts "Thanks for your try, love you, #{@player.name}"
  end
end

Game.new.run




