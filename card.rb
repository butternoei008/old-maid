class Card 
    RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    SUITS = %w(Spade Heart Club Diamond)
    # โพดำ โพแดง ดอกจิก
    
    attr_accessor :rank, :suit

    def initialize(id) 
       
        self.rank = RANKS[id % 13]
        self.suit = SUITS[id % 4]

    end

end

class Deck
    attr_accessor :cards
    def initialize
        self.cards = (0..51).to_a.shuffle.collect{
            |id| Card.new(id)
        }
    end
end

class Old_maid

    def draw_card
        d = Deck.new

        card_deck = []
        
        d.cards.each do |card|
            card_deck << card.rank
        end
        return card_deck
    end

    def player(deck) 

        player_1 = []
        player_2 = []

        switch = 1

        deck.each do |draw|

            if switch.even?
                player_1 << draw
            else
                player_2 << draw
            end

            switch += 1

        end

        return [player_1, player_2]
    end

end

odm = Old_maid.new

draw_card = odm.draw_card
old_maid = draw_card.pop()

player = odm.player(draw_card)

puts "Old maid: #{old_maid}"
puts "Bot: #{player[1]}"
puts "Player1: #{player[0]}"