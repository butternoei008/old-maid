require_relative 'card'

odm = Old_maid.new

draw_card = odm.draw_card
old_maid = draw_card.pop()

player = odm.player(draw_card)
deck_player = odm.match_pop(player[1])
deck_bot = odm.match_pop(player[0])

switch = 1;

loop do
    deck_scret = odm.deck_scret(deck_bot)

    odm.monitor(old_maid, deck_scret, deck_player)
    
    if switch == 1
        choose_card = odm.choose_card(deck_bot)
        card_pop = deck_bot.delete_at(choose_card-1)
        deck_player << card_pop
        
        deck_player = odm.match_pop(deck_player)

        switch = 2
    elsif switch == 2
        choose_card = deck_player.sample
        puts "Bot choose card: #{choose_card}"
        deck_bot << choose_card
        deck_bot = odm.match_pop(deck_bot)

        deck_player.delete_at(deck_player.find_index(choose_card))

        switch = 1
    end

    odm.monitor(old_maid, deck_bot, deck_player)

    if deck_player.length == 0 && deck_bot.length == 1
        puts "\nYou win!!!"
    elsif deck_player.length == 1 && deck_bot.length == 0
        puts "\nYou noob!!!"
    end

    break if deck_player.length == 0 && deck_bot.length == 1 || deck_player.length == 1 && deck_bot.length == 0

end