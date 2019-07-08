require_relative 'card'

odm = Old_maid.new

draw_card = odm.draw_card
old_maid = draw_card.pop()

player = odm.player(draw_card)
deck_bot = odm.match_pop(player[0])
deck_scret = odm.deck_scret(deck_bot)
deck_player = odm.match_pop(player[1])

puts "Old maid: #{old_maid}"
puts "Bot: #{deck_scret}"
puts "Player: #{deck_player}"