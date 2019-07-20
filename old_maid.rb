require_relative 'card'

odm = Old_maid.new

draw_card = odm.draw_card
old_maid = draw_card.pop()

players_num = odm.num_of_player()
player = odm.player(draw_card, players_num)

deck_player = odm.match_pop(player[0])

deck_bot = odm.deckBotMathPop(player, players_num) 

# switch = 1;

loop do
    deck_scret = odm.deck_scret(deck_bot)

    odm.monitor("?", deck_scret, deck_player)
    
#     if switch == 1
#         choose_card = odm.choose_card(deck_bot)
#         card_pop = deck_bot.delete_at(choose_card-1)
#         deck_player << card_pop
        
#         deck_player = odm.match_pop(deck_player)

#         switch = 2
#     elsif switch == 2
#         choose_card = deck_player.sample
#         puts "Bot choose card: #{choose_card}"
#         deck_bot << choose_card
#         deck_bot = odm.match_pop(deck_bot)

#         deck_player.delete_at(deck_player.find_index(choose_card))

#         switch = 1
#     end
    break
#     break if deck_player.length == 0 && deck_bot.length == 1 || deck_player.length == 1 && deck_bot.length == 0
    
end

# odm.monitor(old_maid, deck_bot, deck_player)

# print "\n---------------RESULT---------------"
# odm.result(deck_player, deck_bot)