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

    puts "Old maid: #{old_maid}"
    puts "Bot: #{deck_bot}"
    puts "Bot: #{deck_scret}"
    puts "Player: #{deck_player}"

    choose_card = odm.choose_card(deck_bot)
    card_pop = deck_bot.delete_at(choose_card-1)
    deck_player << card_pop

    break if deck_player.length == 0 && deck_bot.length == 1 || deck_bot.length == 0 && deck_player.length == 1

end
