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

    def num_of_player()
        num = 0

        loop do
            print "Choose the number of players 2-4: "
            num = gets.chomp.to_i

            if num == 2 || num == 3 || num == 4
                return num
                break 
            else
                puts "Choose of 2-4 only!"
            end
        end

        return num
    end

    def player(deck, players_num) 
        players_of = Array.new(players_num, [])

        switch = 0

        deck.each do |draw|
            index = switch % players_num

            players_of[index] += [draw]

            switch += 1
        end

        return players_of
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

    def deckBotMathPop(get_deck, players_num) 
        deck_bot = Array.new(players_num, [])

        (1..players_num-1).each do |deck|
            deck_bot[deck] += self.match_pop(get_deck[deck])
        end

        deck_bot.shift()

        return deck_bot
    end

    def deck_scret(deck_reveal)

        deck_sc = deck_reveal.map do |deck| 
            i = 0 
            deck.map do |card|
                "{#{i += 1}}"
            end
        end

        return deck_sc
    end

    def monitor(old_maid, deck_scret, deck_player)
        puts "\nOld maid: #{old_maid}"

        i = 0
        deck_scret.each do |card|
            puts (deck_scret.length > 1 ? "Bot#{i+1}: " : "Bot: ") + "#{deck_scret[i]}"
            i += 1
        end
        
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

    def result(deck_player, deck_bot)
        if deck_player.length == 0 && deck_bot.length == 1
            puts "\n              YOU WIN!!!"
        elsif deck_player.length == 1 && deck_bot.length == 0
            puts "\n             YOU NOOB!!!"
        end
    end 

end