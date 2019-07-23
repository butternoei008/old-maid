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

class OldMaid
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

            if num > 1 && num < 5
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
        puts "Player: #{deck_player}" 

        i = 0
        deck_scret.each do |card|
            puts (deck_scret.length > 1 ? "Bot#{i+1}: " : "Bot: ") + "#{deck_scret[i]}"
            i += 1
        end
        
    end

    def choose_card(deck_card) 
        loop do
            print "Player choose card: "
            card = gets.chomp().to_i

            if(card > deck_card.length || card < 1) 
                puts "Cant'n choose card! try again"
            else
                return card
                break if card <= deck_card.length
            end
        end
    end

    def end_game(deck_player, deck_bot) 
        player = deck_player
        bot = []

        deck_bot.map do |check_bot|
            if check_bot.length > 0
                bot << "hc"
            end
        end

        if player.length == 0 && bot.length == 1
            return [false, "player"]
        elsif player.length == 1 && bot.length == 0
            return [false, "bot"]
        else
            return [true, "countinue"]
        end
    end

    def result(result_game)
        if result_game[1] == "player"
            puts "\n              YOU WIN!!!"
        else
            puts "\n             YOU NOOB!!!"
        end
    end 
end

class Engine
    def game
        odm = OldMaid.new

        draw_card = odm.draw_card
        old_maid = draw_card.pop()

        players_num = odm.num_of_player()
        player = odm.player(draw_card, players_num)

        deck_player = odm.match_pop(player[0])

        deck_bot = odm.deckBotMathPop(player, players_num) 

        switch = 0
        last_bot = players_num - 2
        result_game = ""

        loop do
            deck_scret = odm.deck_scret(deck_bot)

            if switch == 0

                odm.monitor("?", deck_scret, deck_player)

                if deck_bot.last.length > 0
                    choose_card = odm.choose_card(deck_bot.last)
                    card_pop = deck_bot.last.delete_at(choose_card-1)
                    deck_player << card_pop
                    
                    deck_player = odm.match_pop(deck_player)
                else
                    puts "Player choose card: -"
                end
                switch = 1
            else
                i = 0
                
                (0..last_bot).each do |index|
                    prev_ = index - 1
                    next_ = index + 1

                    if index == 0 && deck_player.length > 0 || index != 0 && deck_bot[prev_].length > 0
                        
                        odm.monitor("?", deck_scret, deck_player)
                        
                        if index == 0
                            choose_card = deck_player.sample
                            deck_player.delete_at(deck_player.find_index(choose_card))
                        else
                            choose_card = deck_bot[prev_].sample
                            deck_bot[prev_].delete_at(deck_bot[prev_].find_index(choose_card))
                        end
                        
                        
                        puts "Bot#{next_} choose card: #{choose_card}"
                        deck_bot[index] << choose_card
                        deck_bot[index] = odm.match_pop(deck_bot[index])
                    else
                        odm.monitor("?", deck_scret, deck_player)
                        puts "Bot#{next_} choose card: -"
                    end

                end

                switch = 0

                
            end

            result_game = odm.end_game(deck_player, deck_bot)
            
            break if result_game[0] == false
        end

        odm.monitor(old_maid, deck_bot, deck_player)

        print "\n---------------RESULT---------------"
        odm.result(result_game)
    end
end

old_maid = Engine.new
old_maid.game