class Card 
    RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    SUITS = %w(Spade Heart Club Diamond)
    
    attr_accessor :rank, :suit

    def initialize(id) 
        self.rank = RANKS[id % 13]
        self.suit = SUITS[id % 4]
    end
end

class Deck
    attr_accessor :cards
    def initialize
        self.cards = (0..51).to_a.shuffle.collect { 
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

    def match_pop(deck_player)
        deck_pop = []

        deck_player.map do |pop|
            deck_pop << pop
        end

        deck_player.each do |pop|
            repeat = deck_pop.count(pop)
            if repeat > 1
                if repeat.even?
                    deck_pop.delete(pop)
                else
                    deck_pop.delete_at(deck_pop.find_index(pop))
                    deck_pop.delete_at(deck_pop.find_index(pop))
                end
            end
        end

        return deck_pop
    end

    def deck_scret(deck_reveal)
        i = 0
        deck_sc = deck_reveal.map {
            |id| "{#{i += 1}}"
        }
        return deck_sc
    end

    def monitor(old_maid, deck_scret, deck_player)
        puts "\nOld maid: #{old_maid}"
        puts "Bot: #{deck_scret}"
        puts "Player: #{deck_player}" 
    end

    def choose_card(deck_card) 
        loop do
            print "Choose card: "
            card = gets.chomp().to_i

            if(card > deck_card.length || card < 1) 
                puts "Cant'n choose card! try again"
            else
                return card
                break if card <= deck_card.length
            end
        end
    end

end