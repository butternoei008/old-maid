# กำหนดว่าการ์ดมีไรบ้าง (กำหนดคุณสมบัติให้การ์ด)
class Card 
    RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    SUITS = %w(Spade Heart Club Diamond)
    
    attr_accessor :rank, :suit

    def initialize(id) 
        self.rank = RANKS[id % 13]
        self.suit = SUITS[id % 4]
    end
end

# สับไพ่
class Deck
    attr_accessor :cards
    def initialize
        self.cards = (0..51).to_a.shuffle.collect { 
            |id| Card.new(id)
        }
    end
end

class OldMaid
    # สร้าง deck กลาง
    def draw_card
        # เรียกใช้ class Deck ค่าที่ได้จะเป็น array
        d = Deck.new

        # สร้างตัวแปรเอาไว้เก็บ Deck กลาง
        card_deck = []
        
        # เอา d มา loop เวลา loop แต่ละครั้งมันจะเอาค่าใน array เก็บไว้ใน card
        d.cards.each do |card|

            # push card.rank เข้าไปในตัวแปร card_deck
            card_deck << card.rank
        end

        return card_deck
    end

    # รับจำนวนผู้เล่น
    def num_of_player()
        # สร้างตัวแปรไว้เก็บจำนวนผู้เล่น
        num = 0

        # สร้าง loop do เผิื่อเจอ user กรอกค่าเกิน 2 - 4 โปรแกรมจะวนกลับมาให้กรอกใหม่
        loop do
            print "Choose the number of players 2-4: "
            # รับจำนวน player
            num = gets.chomp.to_i

            # ถ้า user กรอกเลข 2 - 5 ให้ออกจาก loop do
            if num > 1 && num < 5
                break 
            else # ถ้า user กรอกเลขนอกเหนือกจาก 2 - 5 ให้แสดง "Choose of 2-4 only!" แล้วกลับไปรับค่าใหม่
                puts "Choose of 2-4 only!"
            end
        end

        return num
    end

    # จั่วการ์ดให้ player ทุกคนโดยรับ 
    def player(deck, players_num) 
        # deck = เดกกลาง 51 ใบ (ที่มี 51 ใบเพราะว่ามันถูก pop ออกจากใน class Engine เพื่อเอาไปทำเป็น old maid)
        # players_num = จำนวนผู้เล่น

        # สร้างตัวแปรเป็น array ชื่อ players_of เอาไว้เก็บการ์ดที่ถูกจั่วมาให้
        # โดยพื้นที่จะถูกจองตามจำนวนผู้เล่นที่รับเข้ามาผ่าน parameter ชื่อว่า players_num
        players_of = Array.new(players_num, [])

        # สร้างตัวแปร switch เอาไว้สลับการจั่วไพ่ให้ผู้เล่น
        switch = 0

        # เอา deck กลางทั้ง 51 ใบที่รับผ่าน parameter มา loop แล้วแจกไพ่ให้ player ทุกคน
        deck.each do |draw|
            # สร้างตัวแปร index เอาไว้บอกว่าจะจั่วการ์ดให้ player ไหน
            # โดยให้อัลกอริทึ่มตามนั้นแหล่ะ ใช้หลักการ mod
            index = switch % players_num    

            # push การ์ดจาก draw เข้าไปใน players_of[ตำแหน่งของ player]
            players_of[index] += [draw]

            switch += 1
        end

        return players_of
    end

    # เอาไว้จับคู่การ์ด ถ้าเจอจะถูก pop ออกไป
    def match_pop(deck_player)
        # อันนี้ตอนทำมีปัญหาถ้าเกิดดึง deck_player มาใช้ตรงๆ เวลาเอาไป loop ตาม length มันจะมีปัญหาตรง length มันจะไม่ลดทีละ 1 
        # แต่ length มันจะลดตามค่าที่ถูก pop ออกไปด้วยทำให้การจับคู่ผิดเพี้ยนไป แถมไม่พอยัง loop ไม่ครบตามจำนวน length จริงๆ อีกต่างหาก
        # เลยสร้างตัวแปร deck_pop ขึ้นมาเอาไว้ให้มันเก็บค่า deck_player แยกออกมา
        deck_pop = []

        # เอา deck_player ที่รับผ่าน parameter มา loop แล้วเก็บค่าใน array ไว้ใน pop
        deck_player.map do |pop|
            # ยัดค่าที่ได้จาก pop ใส่ใน deck_pop
            deck_pop << pop
        end
        # ที่นี้ค่าที่อยู่ใน deck_pop ก็จะเหมือนกันกับ deck_player เลย เก็บแยกกันจะได้มันมีปัญหาเรื่อง length ถูกลบเวลามันโดน pop
        # ก็เอา deck_player ไว้ loop ส่วน deck_pop เอาไว้เป็นตัวถูก pop แทน
        
        # เอา deck_player มา loop แล้วเก็บค่าใน array ไว้ใน pop
        deck_player.each do |pop|

            # นับค่า pop ที่อยู่ใน deck_pop ว่ามีเท่าไหร่ แล้วเก็บไว้ในตัวแปร repeat
            repeat = deck_pop.count(pop)

            # ถ้าเจอมากว่า 1 แสดงว่าต้องมีอย่างน้อย 1 คู่ละ
            if repeat > 1

                # ตรวจสอบดูว่าจำนวนที่เจอเป็นเลข คู่ หรือ คี่
                if repeat.even?

                    # ถ้าเป็นเลขคู่ในลบ ค่าที่เจอออกจาก array เลย
                    deck_pop.delete(pop)
                else

                    # ถ้าเป็นเลขคี่แสดงว่าอย่างน้อยต้องเหลือการ์ดให้ player 1 ใบ เพราะมันจะถูก pop ออกก็ต่อเมื่อมันจับคู่ได้เท่านั้น
                    deck_pop.delete_at(deck_pop.find_index(pop))
                    deck_pop.delete_at(deck_pop.find_index(pop))
                end
            end
        end

        # retrun deck_pop หลังจากถูกจับคู่ pop แล้วออกไป
        return deck_pop
    end

    # เอาไว้จับคู่การ์ดให้ bot
    def deckBotMathPop(get_deck, players_num) 
        # get_deck = deck ของ player ทั้งหมด
        # players_num = จำนวนผู้เล่น

        # สร้างตัวแปร deck_bot เอาไว้เก็บการ์ดของบอททุกคน
        deck_bot = Array.new(players_num, [])

        # จากนั้น loop 1 ถึง [จำนวนผู้เล่น] แล้วเก็บค่าจำนวน loop ลงใน |deck|
        # สาเหตุที่ต้องเริ่มจาก 1 เพราะว่า players_num index ที่ 0 เรายกให้เป็น deck ของ player ไปแล้ว
        # เลยต้องให้มัน loop ตั้งแต่ 1 ขึ้นไปเพื่อที่ deck ของ player จะไม่โดนลูกหลงไปด้วย
        # สาเหตุที่ต้องให้ players_num - 1 เพราะว่าใน array index มันเริ่มจาก 0
        # แต่เลขที่รับจาก user มามันเริ่มจาก 1 เราเลยต้องให้ players_num - 1 เพื่อที่เลขจะได้ match กับจำนวน length ของ array
        (1..players_num - 1).each do |deck|
            
            # เอา deck ของบอทไปจับคู่แล้ว ยัดค่าที่ def match_pop มัน retrun ออกมา ยัดใส่ใน deck_bot[botที่ 1..players_num-1]
            deck_bot[deck] += self.match_pop(get_deck[deck])
        end

        # เนื่องจากว่า deck_bot ใน index ที่ 0 มันเป็นของ player
        # เราเลยใช้คำสั่ง .shift() เป็นการลบ array index แรกออก
        deck_bot.shift()

        # return deck_bot ที่ถูกจับคู่แล้วออกไป
        return deck_bot
    end

    # ปิด deck ของ bot เป็นความรับแบบนี้ ["{1}", "{2}", "{3}"]
    def deck_scret(deck_reveal)
        # deck_reveal = จำนวน deck ของ bot

        # สร้างตัวแปร deck_sc เอาไว้เก็บ array ที่ถูกปิดแล้ว แบบนี้ >>> ["{1}", "{2}", "{3}"]
        # เอา deck_reveal มา loop ตามจำนวน deck ของ bot
        deck_sc = deck_reveal.map do |deck| 
            i = 0 
            # loop นี้เอาไว้เข้าถีงการ์ดใน deck ของ bot แล้วเก็บค่านั้นไว้ใน |card|
            deck.map do |card|
                # แล้วทำให้มันกลายเป็น แบบนี้ >>> ["{1}", "{2}", "{3}"]
                "{#{i += 1}}"
            end
        end

        # retrun deck ที่ถูกปกปิดแล้วจะได้ แบบนี้ >>> ["{1}", "{2}", "{3}"]
        return deck_sc
    end

    # เอาไว้โชว์ข้อมูลการ์ดของ ผู้เล่น และ bot
    def monitor(old_maid, deck_scret, deck_player)
        # old_maid = ไพ่อีแก่
        # deck_scret = deck ของ bot
        # deck_player = deck ของ player

        # แสดง ไพ่อีแก่
        puts "\nOld maid: #{old_maid}"

        # แสดง deck ของ player
        puts "Player: #{deck_player}" 

        # สร้างตัวแปร i เอาไว้โชว์ลำดับของ bot
        i = 0
        deck_scret.each do |card|
            # ถ้ามี bot มากกว่า 1 ตัวให้แสดงเป็น Bot1 Bot2 Bot3 บลาๆๆๆ 
            # ถ้ามีแค่ 1 ตัวให้แสดง Bot เฉยๆ
            puts (deck_scret.length > 1 ? "Bot#{i+1}: " : "Bot: ") + "#{deck_scret[i]}"

            # ให้ i บวกทีละ 1 เพื่อให้เป็นลำดับของ Bot
            i += 1
        end
        
    end

    # รับค่าการ์ดที่ผู้ใช้เลือก
    def choose_card(deck_card)
        # สร้างตัวแปร card ไว้เก็บ ค่าที่ user เลือก
        card = ""

        # สร้าง loop do ไว้เวลา user error โปรแกรมวนมาให้ user กรอกค่าเข้าไปใหม่
        loop do
            print "Player choose card: "
            # รับค่าที่ user เลือก
            card = gets.chomp().to_i

            # ถ้าค่าที่ user กรอกเข้ามา จำนวนเกิน การ์ดที่ bot มีอยู่
            # จะโชว์ข้อความ "Cant'n choose card! try again"
            if(card > deck_card.length || card < 1) 
                puts "Cant'n choose card! try again"
            else # ถ้าค่าที่ user กรอกเข้ามา =< จำนวนการ์ดที่บอทมีอยู่
                # ก็ทำการเบรค loop ซะ
                break if card <= deck_card.length
            end
        end

        # return การ์ดที่ผู้ใช้เลือก
        return card
    end

    # เอาไว้หาผู้ชนะ
    def end_game(deck_player, deck_bot) 
        # deck_player = รับ deck ของ player เข้ามา
        # deck_bot = รับ deck ของ bot เข้ามา

        # สร้างตัวแปร player เอาไว้เก็บ deck ของ player
        player = deck_player

        # สร้างตัวแปร bot เอาไว้เก็บ deck ของ bot
        bot = []

        # deck ของ bot มา loop แล้วเอาค่าใน array เก็บไว้ใน |check_bot|
        deck_bot.map do |check_bot|

            # ถ้า deck ของ bot ตัวที่ n มี length มากกว่า 0
            # ให้ยัด "hc" เข้าไปในตัวแปร bot (ตรงคำว่า "hc" จะเป็นคำไหนก็ได้แค่ push เข้าไปให้มันมีตัวแปร bot มันมี length ไว้เช็ค if เฉยๆ)
            if check_bot.length > 0
                bot << "hc"
            end
        end

        if player.length == 0 && bot.length == 1        # ถ้า player ไม่มี card แล้ว && bot ตัวใดตัวหนึ่งมีการ์ดเหลือในมือ

            # retrun ออกไปเป็น array ตัวแรกคือ false เพื่อให้มันหยุด loop do ตัวสองคือ "player" บอกว่าใครชนะ
            return [false, "player"]

        elsif player.length == 1 && bot.length == 0     # ถ้า player มีการ์ดเหลือดในมือ && bot อย่างน้อย 1 ทุกตัวไม่มี card แล้ว 

            # retrun ออกไปเป็น array ตัวแรกคือ false เพื่อให้มันหยุด loop do ตัวสองคือ "bot" บอกว่าใครชนะ
            return [false, "bot"]
            
        else    # ถ้ายังหาผู้ชนะไม่ได้ก็

            # retrun true เพื่อให้มันทำ loop do ต่อไปส่วน "countinue" ใส่ไว้ให้มันมี index ให้ครบ 2 ตัวเฉยไม่มีไรไม่ได้ใช้งาน
            return [true, "countinue"]
        end
    end

    # ประกาศว่าใครชนะ
    def result(result_game)
        # รับเข้ามาเป็น array ที่ถูก retrun มาจาก def end_game

        # แล้วเอา index มาตรวจดูถ้ามัน == player มั้ย
        if result_game[1] == "player"
            # ถ้าใช่แสดงว่าเราชนะ
            puts "\n              YOU WIN!!!"
        else
            # นอกเหนือจากนั้นคือเราแพ้
            puts "\n             YOU NOOB!!!"
        end
    end 
end

class Engine

    # ตัว run game
    def game
        # สร้างตัวแปร odm เอาไว้เรียกใช้งานของใน class OldMaid
        odm = OldMaid.new

        # สร้างตัวแปร old_maid เอาไว้เก็บ deck กลาง
        draw_card = odm.draw_card

        # สร้างตัวแปร ให้ไพ่บนสุดเป็น old maid โดยการ pop มันออกมา
        old_maid = draw_card.pop()

        # สร้างตัวแปร players_num เอาไว้เก็บ จำนวนผู้เล่น
        players_num = odm.num_of_player()

        # สร้างตัวแปร player เอาไว้เก็บ deck ของ player และ bot เป็น array ซ้อน array
        # [[deck0], [deck1], [deck2], [deck3]]
        player = odm.player(draw_card, players_num)

        # สร้างตัวแปร deck_player เอาไว้เก็บ deck ของ player โดยให้ player[0] เป็น deck ของ player
        # แล้วเรียกใช้ def match_pop เอา deck ของ player เข้าไปตรวจว่าจับคู่ได้หรือไม่
        # แล้ว match_pop จะ retrun ออกเป็น deck uniq ออกมา คือไม่มีการ์ดซ้ำนั่นเอง
        deck_player = odm.match_pop(player[0])

        # สร้างตัวแปร deck_bot เอาไว้เก็บ deck ของ bot
        # แล้วเรียกใช้ def deckBotMathPop
        # แล้ว deckBotMathPop จะ retrun ออกเป็น deck uniq ออกมา คือไม่มีการ์ดซ้ำนั่นเอง
        # ในที่นี้โยน player ลงไปทั้งก้อนนั่นหมายถึงโยน deck ของ player ลงไปด้วยแต่ไม่ต้องห่วงเดี๋ยว deckBotMathPop มันไปแยกให้เอง แล้วมันจะ return ออกมาเฉพาะ deck ของ bot
        deck_bot = odm.deckBotMathPop(player, players_num) 

        # สร้างตัวแปร switch เอาไว้สลับ turn ของผู้เล่นและ bot
        switch = 0

        # สร้างตัวแปร last_bot เอาไว้ select bot ตัวสุดท้าย
        # สาเหตุที่ต้องเป็น players_num - 2 เพราะว่าค่า players_num ที่รับมาจาก user คือจำนวน bot รวมถึงผู้เล่นด้วยแค่เราต้องการนับแค่ bot เลยต้อง -1 เพื่อไม่ให้มันนับ player
        # แล้วจำนวนที่ user กรอกเข้ามาคือ 1-4 แต่ array มันเริ่มตั้งแต่ 0 เราจึงต้อง -1 อีก เพื่อให้มัน match กัน length ของ array ทั้งหมดรวมกันก็ได้ลบ -2
        last_bot = players_num - 2

        # สร้างตัวแปร result_game เอาไว้เก็บผลแพ้ชนะ
        result_game = ""

        # สร้าง loop do ให้มันวนเล่นจนกว่าจะรู้ผล แพ้ ชนะ
        loop do
            # สร้างตัวแปร deck_scret เอาไว้ปิดไพ่ของ bot เป็นความรับ
            deck_scret = odm.deck_scret(deck_bot)

            # ถ้า switch == 0 คือเทิร์นของ player
            if switch == 0
                
                # แสดงแดงของมูลการ์ด
                odm.monitor("?", deck_scret, deck_player)

                # player ต้องหยิบการ์ดจาก deck bot ตัวสุดท้าย
                # ถ้า bot ตัวสุดท้ายมีการ์ดอยู่
                if deck_bot.last.length > 0

                    # ให้ user เลือกการ์ดจาก deck ของ bot ตัวสุดท้าย เก็บไว้ในตัวแปร choose_card
                    choose_card = odm.choose_card(deck_bot.last)

                    # ลบการ์ดออกจาก deck ของ bot ตัวสุดท้าย แล้วเก็บค่าการ์ดที่ลบไปใส่ตัวแปร card_pop
                    # สาเหตุที่ต้องให้ choose_card - 1 เพราะว่าจะไม่มัน match กับ length ของ array
                    card_pop = deck_bot.last.delete_at(choose_card - 1)

                    # เอาการ์ดที่เก็บไว้ในตัวแปร card_pop ยัดเข้าไปใน array ของ deck_player
                    deck_player << card_pop
                    
                    # แล้วเอา deck_player ไปตรวจดูว่ามันจับคู่ได้มั้ย
                    # ถ้าได้ match_pop มันจะ retrun deck uniq ออกมา
                    deck_player = odm.match_pop(deck_player)

                else # ถ้า bot ตัวสุดท้ายไม่มีการ์ดเหลืออยู่มันจะ โชว์ข้อความ "Player choose card: -" แล้วข้ามเทิร์นเราไป
                    puts "Player choose card: -"
                end

                # ให้ switch = 1 เพื่อให้เข้าเทิร์นของ bot
                switch = 1
            else
                # loop ตั้วแต่ 0 - last_bot แล้วเก็บค่า 0 - last_bot ไว้ใน |index|
                (0..last_bot).each do |index|
                    # สร้างตัวแปร prev_ เอาไว้เป็นเงือนไขให้มันเทียบกับ bot ก่อนหน้า
                    prev_ = index - 1
                    # สร้างตัวแปร next_ เอาไว้เป็นเงือนไขให้มันเทียบกับ bot ตัวต่อไป
                    next_ = index + 1
 
                    # ถ้า bot ตัวแรก && deck_player มีการ์ดอยู่  ||   ถ้าไม่ใช่ bot ตัวแรก && deck_bot ตัวก่อนหน้าไปมีการ์ดอยู่
                    if index == 0 && deck_player.length > 0 || index != 0 && deck_bot[prev_].length > 0
                        
                        # แสดงข้อมูลการ์ด
                        odm.monitor("?", deck_scret, deck_player)
                        
                        # ถ้าเป็น bot ตัวแรก
                        if index == 0
                            # มันมันสุ่มเลือกการ์ดจาก deck_player
                            choose_card = deck_player.sample

                            # แล้วลบการจาก deck_player
                            deck_player.delete_at(deck_player.find_index(choose_card))

                        else # ถ้าไม่ใช่ bot ตัวแรก
                            # ให้เลือกการ์ดจาก bot ตัวก่อนหน้า
                            choose_card = deck_bot[prev_].sample
                            # แล้วลบการ์ดออกจาก bot ตัวก่อนหน้าซะ
                            deck_bot[prev_].delete_at(deck_bot[prev_].find_index(choose_card))
                        end
                        
                        # แสดงว่า bot ตัวที่ [index] เลือกการ์ดอะไรไป
                        puts "Bot#{next_} choose card: #{choose_card}"

                        # เอาการ์ดที่ bot ตัวที่ [index] เลือกยัดเข้าไปใน deck ของตัวเอง
                        deck_bot[index] << choose_card

                        # เอาการ์ดของ bot ตัวที่ [index] ไปจับคู่ แล้ว match_pop จะ return deck uniq ออกมา
                        deck_bot[index] = odm.match_pop(deck_bot[index])
                    
                    else # ถ้า bot[index] ไม่สามารถจาก  bot[prev_] ก็คือ bot[prev_] lenght มันเท่ากับ 0 นั่นเอง

                        # แสดงข้อมูลการ์ด
                        odm.monitor("?", deck_scret, deck_player)
                        # แสดงให้รู้ว่ากูไม่ได้เลือกการ์ดไปนะ แล้วก็ข้ามเทิร์นไป
                        puts "Bot#{next_} choose card: -"
                    end

                end

                # ให้ switch = 0 เพื่อให้กลับไปที่เทิร์นของ player
                switch = 0

            end

            # สร้างตัวแปร result_game เอาไว้เก็บผลว่าเจอผู้ แพ้ ชนะ หรือยัง
            # end_game จะ retrun ออกมาเป็น array [true, "who"] ("who" คือแทนผู้ชนะ)
            result_game = odm.end_game(deck_player, deck_bot)
            
            # หยุด loop เมื่อเจอผู้ชนะแล้ว
            break if result_game[0] == false
        end

        # แสดงการ์ดทั้งหมดพร้อมทั้งแสดง old_maid
        odm.monitor(old_maid, deck_bot, deck_player)

        print "\n---------------RESULT---------------"
        # เรียก def result มาใช้ โยน result_game เข้าไปเช็ค
        # แล้ว result_game จะแสดงว่า player ชนะหรือแพ้
        odm.result(result_game)
    end
    
end

# เรียนใช้งาน class Engine
old_maid = Engine.new
# Run game!!
old_maid.game