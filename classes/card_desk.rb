require_relative 'card'
class CardsDesk
  attr_reader :cards

  SUIT =["\u2662","\u2664","\u2665","\u2667"]
  HIGH_CARDS = [:A,:K,:Q,:J]
  LOW_CARDS = [2,3,4,5,6,7,8,9,10]
  def initialize
    @cards=[]
    SUIT.each {|suit|create_suit(suit)}
  end

  def desk_count
    i=0
    @cards.each {|value| i+=1}
    puts "карт в колоде: #{i}"
  end

  private
  def create_suit(suit)
    HIGH_CARDS.each {|value| @cards.push(Card.new(suit,10,value))}
    LOW_CARDS.each {|value| @cards.push(Card.new(suit,value,value))}
  end
end
