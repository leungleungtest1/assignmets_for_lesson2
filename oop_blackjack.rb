# There are 1 deck, 52 cards, 2 player


# Deck is an array of 52 cards(objects)
class Deck 
  attr_accessor :cards_d
  def initialize 
    @cards_d = []
    no_cards = ['S','H','D','C'].product(['2','3','4','5','6','7','8','9','10','J','Q','K','A'])
    no_cards.each{|array| @cards_d<<Card.new(array[0],array[1])}  
  end

end

# Card is a object contains value of suits('String') and numbers ('String') 
class Card
  attr_accessor :suit, :number
  def initialize(suit,number)
    @suit=suit
    @number=number
  end

  
end

# Player is a object contains values of name ('String') and cards_p ('Array' of 'Object_Card') # real_cards_p is an array of cards ('string_Card')
class Player
  attr_accessor :name, :cards_p, :real_cards_p
  def initialize(name,cards_p=[],real_cards_p=[])
    @name = name
    @cards_p = cards_p
    @real_cards_p = real_cards_p
  end

  def has_ace?(player)
    if player.real_cards_p.include?("SA")|| player.real_cards_p.include?("HA")||player.real_cards_p.include?("DA")||player.real_cards_p.include?("CA")   
      return true
    else
      return false
    end
    
  end

end



class Game
  attr_accessor :deck, :player
  def initialize 
    @deck = Deck.new
    @player = Player.new('Nathan')
    @dueler = Player.new('Dueler') 
  end 

  def wash_card
   @deck.cards_d.shuffle!                      
  end

  def player_draw_a_card (player)
    player.cards_p.push(@deck.cards_d[-1])                                      #cards_p is a an array of cards (object)
    player.real_cards_p.push(@deck.cards_d[-1].suit+@deck.cards_d[-1].number)  # real_cards_p is an array of cards (string)
    @deck.cards_d.pop
  end

  def check_result(player)
    sum = 0                                              
    player.cards_p.each{|o|
      if o.number == "J" || o.number == "Q"|| o.number == "K"
        sum +=10
      elsif o.number == "A"
        sum +=1
      else
        sum += o.number.to_i
      end
    }


    if sum > 21
      return "#{player.name},You are busted!"
    elsif sum == 21
      return "BlackJack! you win!"
    elsif sum ==11 && has_ace?(player)
      return "BlackJack! you win!"
    end

  end

  def has_ace?(player)
    if player.real_cards_p.include?("SA")|| player.real_cards_p.include?("HA")||player.real_cards_p.include?("DA")||player.real_cards_p.include?("CA")   
      return true
    else
      return false
    end
    
  end



def check_result_4_dueler (player,dueler)                       #check result of the game of dueler at anytime
  sum_p =0                                               
    player.cards_p.each{|o|
      if o.number == "J" || o.number == "Q"|| o.number == "K"
        sum_p +=10
      elsif o.number == "A"
        sum_p +=1
      else
        sum_p += o.number.to_i
      end
    }
  sum = 0
    dueler.cards_p.each{|o|
      if o.number == "J" || o.number == "Q"|| o.number == "K"
        sum +=10
      elsif o.number == "A"
        sum +=1
      else
        sum += o.number.to_i
      end
    }
  if sum > sum_p and sum>16 and sum<21
    return "Dueler won!"
  elsif sum > 21                                                           # the condition of bust is  over 21
    return "Dueler is busted and you won!"
  elsif sum == 21                                                       # general win situation withour ACE
    return "Dueler won!"
  elsif sum == 11 and has_ace?(dueler)                      # for you have at least ONE ACE and number = 11
    return "Dueler won!"
  else
  end
end




  def run
   begin 
    @deck = Deck.new
    @player = Player.new('Nathan')
    @dueler = Player.new('Dueler') 
    play_or_exit = nil  
    puts "Welcome to blackjacks!"
    begin 
      puts "What is your name?"
      player_name = gets.chomp
      @player.name = player_name
    end until player_name != ""

    wash_card
   
     player_draw_a_card(@player)
     player_draw_a_card(@player)

     player_draw_a_card(@dueler)
     player_draw_a_card(@dueler)

    puts "#{@player.name}, you are given the cards : #{@player.real_cards_p}."
    puts "#{@dueler.name} are given the cards : #{@dueler.real_cards_p}."


    begin 
      break if check_result(@player)
      break if check_result(@dueler)
      puts "you wanna hit or stay!(H/S)"
      player_choice = gets.chomp.downcase
    end until player_choice == "h" || player_choice =="s"

    puts check_result(@player)if check_result(@player)
    puts check_result(@dueler) if check_result(@dueler)

    while player_choice == "h"
    player_draw_a_card(@player)    
    puts "#{@player.name}, you are given the cards #{@player.real_cards_p}"
    break if check_result(@player)
    begin 
    puts "you wanna hit or stay!(H/S)"
    player_choice = gets.chomp.downcase
    end until player_choice == "h" || player_choice =="s"
    end
    puts check_result(@player)if check_result(@player) 

    puts check_result_4_dueler(@player,@dueler)  if check_result_4_dueler(@player,@dueler)

    while player_choice == "s"
      break if check_result_4_dueler(@player,@dueler)
      player_draw_a_card(@dueler)
      puts "Dueler are given the cards : #{@dueler.real_cards_p}."
      break if check_result_4_dueler(@player,@dueler)                              # testing
      end 
      puts check_result_4_dueler(@player,@dueler)           #testing

      loop do
      puts "Play again or exit? (P/E)"
      play_or_exit = gets.chomp.downcase
      break if play_or_exit == "p" || play_or_exit =="e"
      end 
      end until play_or_exit == "e"
      puts "Thank you for trying,#{@player.name} "
  end


end

game1= Game.new
game1.run



