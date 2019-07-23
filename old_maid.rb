require_relative 'card'

odm = Old_maid.new

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

        odm.monitor("?", deck_bot, deck_player)

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
            forward = index - 1

            if index == 0 && deck_player.length > 0 || index != 0 && deck_bot[forward].length > 0
                
                odm.monitor("?", deck_bot, deck_player)
                
                if index == 0
                    choose_card = deck_player.sample
                    deck_player.delete_at(deck_player.find_index(choose_card))
                else
                    choose_card = deck_bot[forward].sample
                    deck_bot[forward].delete_at(deck_bot[forward].find_index(choose_card))
                end
                
                
                puts "Bot#{forward} choose card: #{choose_card}"
                deck_bot[index] << choose_card
                deck_bot[index] = odm.match_pop(deck_bot[index])
            else
                odm.monitor("?", deck_bot, deck_player)
                puts "Bot#{forward} choose card: -"
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