# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Admin User
larry = User.new(
  :email => "lcreid@jadesystems.ca",
  :password => "garbage",
  :name => "Larry Reid",
  :user_guid => nil
  )
larry.encrypted_password = "$2a$10$MVDA5xDDy1M6.ZcEhnjEsuyfNKCh6o1LPcDQ6XbGR8NheNNA.TkwK"
larry.admin = true
larry.save!

# The Founding User
marcos = User.new(
  :email => "reidcontreras@gmail.com",
  :password => "garbage",
  :name => "Marcos",
  :user_guid => nil
  )
marcos.encrypted_password = "$2a$10$RP1XmPyVIH4eyiJa3bmcNetYIy.I/w0bUOMSQEYhR1fcpFPhKF5Rq"
marcos.save!

cp = ChildParent.create :parent_id => larry.id, :child_id => marcos.id
cp.save!

[
  [
  { :title => "Plurals", :due_date => "2012-Apr-11", :user_id => larry.id },
    [
    { :word => "words", :sentence => "These words are plurals.", :word_order => 0 },
    { :word => "hours", :sentence => "We practice spelling for hours.", :word_order => 1 },
    { :word => "dishes", :sentence => "Wash the dishes and leave them to dry.", :word_order => 2 },
    { :word => "pieces", :sentence => "Pick up the pieces of the dishes that got broken.", :word_order => 3 },
    { :word => "lunches", :sentence => "We have several hot lunches per year.", :word_order => 4 },
    { :word => "eyes", :sentence => "His eyes were closed.", :word_order => 5 },
    { :word => "inches", :sentence => "Football is a game of inches.", :word_order => 6 },
    { :word => "houses", :sentence => "Houses in Vancouver are expensive.", :word_order => 7 },
    { :word => "glasses", :sentence => "Don't touch someone's glasses unless they say it's okay.", :word_order => 8 },
    { :word => "wishes", :sentence => "Our best wishes to you and your family.", :word_order => 9 },
    { :word => "boys", :sentence => "The boys are outside playing.", :word_order => 10 },
    { :word => "passes", :sentence => "He passes the puck when he should shoot.", :word_order => 11 },
    { :word => "foxes", :sentence => "The foxes were hiding in their den.", :word_order => 12 },
    { :word => "girls", :sentence => "The girls had a great soccer team.", :word_order => 13 },
    { :word => "patches", :sentence => "He had some stylish patches on his jeans.", :word_order => 14 },
    { :word => "classes", :sentence => "There are two grade four classes.", :word_order => 15 },
    { :word => "years", :sentence => "It seems like years since we've known each other.", :word_order => 16 },
    { :word => "friends", :sentence => "They had been friends for a long time.", :word_order => 17 },
    { :word => "guesses", :sentence => "His guesses weren't very good.", :word_order => 18 },
    { :word => "bushes", :sentence => "They found the ball in the bushes.", :word_order => 19 },
    { :word => "things", :sentence => "Some things were meant to be left alone.", :word_order => 20 },
    { :word => "riches", :sentence => "There are more riches in the world than money.", :word_order => 21 },
    { :word => "months", :sentence => "The summer months are my favorite time.", :word_order => 22 },
    { :word => "boxes", :sentence => "The packed the boxes with their things.", :word_order => 23 }
    ]
  ],
  [
  { :title => "C Words", :due_date => "", :user_id => larry.id },
    [
    { :word => "call", :sentence => "Please give me a call when you want to talk.", :word_order => 0 },
    { :word => "core", :sentence => "Eat your apple and throw the core in the compost bin.", :word_order => 1 },
    { :word => "cast", :sentence => "He broke his arm and had to wear a cast for six weeks.", :word_order => 2 },
    { :word => "sent", :sentence => "She sent the package by regular mail.", :word_order => 3 },
    { :word => "cinch", :sentence => "Cinch your belt tightly or your pants will fall down.", :word_order => 4 },
    { :word => "count", :sentence => "Count from one to one hundred by twos.", :word_order => 5 },
    { :word => "cycle", :sentence => "Rain is part of the water cycle.", :word_order => 6 },
    { :word => "cent", :sentence => "It's hard to buy anything with one cent anymore.", :word_order => 7 },
    { :word => "cool", :sentence => "Spelling is so cool.", :word_order => 8 },
    { :word => "since", :sentence => "I have been here since last year.", :word_order => 9 },
    { :word => "calm", :sentence => "Please remain calm and walk to the exits.", :word_order => 10 },
    { :word => "calf", :sentence => "The mother cow gave milk to her calf.", :word_order => 11 },
    { :word => "comb", :sentence => "Comb your hair and brush your teeth.", :word_order => 12 },
    { :word => "city", :sentence => "The city is full of many people.", :word_order => 13 },
    { :word => "curve", :sentence => "The curve in the road was very dangerous.", :word_order => 14 },
    { :word => "cell", :sentence => "The world is full of single-cell organisms.", :word_order => 15 },
    { :word => "cope", :sentence => "I hope you can cope with the spelling test.", :word_order => 16 },
    { :word => "scent", :sentence => "The scent of flowers is strong in the spring.", :word_order => 17 },
    { :word => "scene", :sentence => "The actors performed the scene for the class.", :word_order => 18 },
    { :word => "centre", :sentence => "Put your cards in the centre of the table.", :word_order => 19 }
    ]
  ],
  [
  { :title => "G Words", :due_date => "", :user_id => larry.id },
    [
    { :word => "game", :sentence => "It's only a game.", :word_order => 0 },
    { :word => "gang", :sentence => "The gang is all here.", :word_order => 1 },
    { :word => "gold", :sentence => "There's gold in those hills.", :word_order => 2 },
    { :word => "gym", :sentence => "We can play floor hockey in the gym.", :word_order => 3 },
    { :word => "gust", :sentence => "The gust of wind blew the papers around the parking lot.", :word_order => 4 },
    { :word => "gentle", :sentence => "Please be gentle with the cat.", :word_order => 5 },
    { :word => "gawk", :sentence => "Don't gawk at the traffic accident.", :word_order => 6 },
    { :word => "germ", :sentence => "One germ can't make you sick.", :word_order => 7 },
    { :word => "gasp", :sentence => "There was a gasp from the crowd.", :word_order => 8 },
    { :word => "gist", :sentence => "I understand the gist of what you're saying.", :word_order => 9 },
    { :word => "gorge", :sentence => "They built a bridge across the gorge.", :word_order => 10 },
    { :word => "gem", :sentence => "It was the most valuable gem ever found.", :word_order => 11 },
    { :word => "jingle", :sentence => "The jingle of the bells made everyone happy.", :word_order => 12 },
    { :word => "giant", :sentence => "The giant airplane slowly rose into the air.", :word_order => 13 },
    { :word => "guy", :sentence => "On guy was standing alone in the field.", :word_order => 14 },
    { :word => "gas", :sentence => "Put some gas in the car.", :word_order => 15 },
    { :word => "gift", :sentence => "He had a gift for talking.", :word_order => 16 },
    { :word => "guest", :sentence => "The guest speaker talked for too long.", :word_order => 17 },
    { :word => "good", :sentence => "The food was good, and the dessert was the best.", :word_order => 18 },
    { :word => "gerbil", :sentence => "Please clean out the gerbil cage.", :word_order => 19 }
    ]
  ],
  [
  { :title => "K words", :due_date => "", :user_id => larry.id },
    [
    { :word => "kind", :sentence => "You're so kind.", :word_order => 0 },
    { :word => "queen", :sentence => "The queen bee is the mother of all the bees in the hive.", :word_order => 1 },
    { :word => "squeeze", :sentence => "Squeeze the toothpaste tube.", :word_order => 2 },
    { :word => "quiz", :sentence => "How do you like the quiz?", :word_order => 3 },
    { :word => "kick", :sentence => "Kick the balls over here, please.", :word_order => 4 },
    { :word => "quiche", :sentence => "I like quiche.", :word_order => 5 },
    { :word => "quick", :sentence => "Take a quick look.", :word_order => 6 },
    { :word => "quake", :sentence => "He began to shiver and quake.", :word_order => 7 },
    { :word => "squash", :sentence => "I like squash.", :word_order => 8 },
    { :word => "knife", :sentence => "The knife is sharp.", :word_order => 9 },
    { :word => "key", :sentence => "Put the key in the lock.", :word_order => 10 },
    { :word => "squat", :sentence => "Let's squat around the campfire.", :word_order => 11 },
    { :word => "quit", :sentence => "Don't quit now.", :word_order => 12 },
    { :word => "squirt", :sentence => "Don't squirt your brother.", :word_order => 13 },
    { :word => "square", :sentence => "Please draw a square.", :word_order => 14 },
    { :word => "quote", :sentence => "This quote is from Churchill.", :word_order => 15 },
    { :word => "quilt", :sentence => "What a lovely quilt.", :word_order => 16 },
    { :word => "squint", :sentence => "The sun made her squint.", :word_order => 17 },
    { :word => "quite", :sentence => "That's quite a bit of word you've done.", :word_order => 18 },
    { :word => "king", :sentence => "The king stood up from his throne.", :word_order => 19 }
    ]
  ],
  [
  { :title => "Vowel Sounds", :due_date => "", :user_id => larry.id },
    [
    { :word => "each", :sentence => "Try to spell each word as best you can.", :word_order => 0 },
    { :word => "speech", :sentence => "The politician gave a rousing speech.", :word_order => 1 },
    { :word => "hitch", :sentence => "Hitch the horse to the cart.", :word_order => 2 },
    { :word => "mulch", :sentence => "Put mulch on the garden.", :word_order => 3 },
    { :word => "bleach", :sentence => "Don't use bleach on coloured clothes.", :word_order => 4 },
    { :word => "snatch", :sentence => "Don't snatch things like that.", :word_order => 5 },
    { :word => "grouch", :sentence => "He's a grouch.", :word_order => 6 },
    { :word => "porch", :sentence => "Let's sit on the porch.", :word_order => 7 },
    { :word => "ranch", :sentence => "We spent the summer at the ranch.", :word_order => 8 },
    { :word => "patch", :sentence => "Put a patch of the knee of those jeans.", :word_order => 9 },
    { :word => "pouch", :sentence => "She kept her treasures in a pouch.", :word_order => 10 },
    { :word => "rich", :sentence => "We're not rich, but we're happy.", :word_order => 11 },
    { :word => "drench", :sentence => "This rain will drench us if we go outside.", :word_order => 12 },
    { :word => "starch", :sentence => "Put starch on the shirts.", :word_order => 13 },
    { :word => "match", :sentence => "Start the campfire with a match.", :word_order => 14 },
    { :word => "coach", :sentence => "The coach said run.", :word_order => 15 },
    { :word => "bunch", :sentence => "That's a nice bunch of carrots.", :word_order => 16 },
    { :word => "latch", :sentence => "Close the latch on the gate.", :word_order => 17 },
    { :word => "crouch", :sentence => "The cat went into a crouch.", :word_order => 18 },
    { :word => "watch", :sentence => "The watch has stopped.", :word_order => 19 }
    ]
  ],
  [
  { :title => "Compound Words", :due_date => "2012-Apr-04", :user_id => larry.id },
    [
    { :word => "headlight", :sentence => "The car's headlight was badly adjusted.", :word_order => 0 },
    { :word => "toothbrush", :sentence => "Put your toothbrush in the bathroom.", :word_order => 1 },
    { :word => "headache", :sentence => "Your headache will go away soon.", :word_order => 2 },
    { :word => "handcuff", :sentence => "I'll handcuff the criminal.", :word_order => 3 },
    { :word => "toothpaste", :sentence => "Put toothpaste on the toothbrush.", :word_order => 4 },
    { :word => "eyebrow", :sentence => "She raised her eyebrow when she saw the spelling words.", :word_order => 5 },
    { :word => "footstep", :sentence => "She thought she heard a footstep.", :word_order => 6 },
    { :word => "handsome", :sentence => "He was handsome when he was young.", :word_order => 7 },
    { :word => "eyelid", :sentence => "He had a hair caught under his eyelid.", :word_order => 8 },
    { :word => "handshake", :sentence => "They sealed the deal with a handshake.", :word_order => 9 },
    { :word => "headway", :sentence => "By digging all day they made headway on the garden.", :word_order => 10 },
    { :word => "handrail", :sentence => "Please hold the handrail.", :word_order => 11 },
    { :word => "toothache", :sentence => "If you don't brush your teeth you'll get a toothache.", :word_order => 12 },
    { :word => "headphone", :sentence => "Take off the headphone and listen.", :word_order => 13 },
    { :word => "football", :sentence => "I can't wait for the World Cup of football.", :word_order => 14 },
    { :word => "handmade", :sentence => "The sweater is handmade.", :word_order => 15 },
    { :word => "toothpick", :sentence => "Get a toothpick from the kitchen table.", :word_order => 16 },
    { :word => "footprint", :sentence => "There was a strange footprint in the snow.", :word_order => 17 },
    { :word => "footstool", :sentence => "Put your feet up on the footstool.", :word_order => 18 },
    { :word => "eyesight", :sentence => "His eyesight was failing.", :word_order => 19 }
    ]
  ],
  [
  { :title => "Plurals 2", :due_date => "2012-Apr-27", :user_id => larry.id },
    [
    { :word => "babies", :sentence => "Put the babies to bed now.", :word_order => 0 },
    { :word => "boys", :sentence => "The boys are playing in the yard.", :word_order => 1 },
    { :word => "dishes", :sentence => "Pick up the dishes and put them in the sink.", :word_order => 2 },
    { :word => "fishes", :sentence => "The fishes are swimming in the tank.", :word_order => 3 },
    { :word => "oxes", :sentence => "The oxes are watching the oxen pull the cart.", :word_order => 4 },
    { :word => "ponies", :sentence => "Wild ponies couldn't drag me away.", :word_order => 5 },
    { :word => "turkeys", :sentence => "We cook two turkeys for Thanksgiving.", :word_order => 6 },
    { :word => "berries", :sentence => "The Saskatoon berries were delicious this year.", :word_order => 7 },
    { :word => "carries", :sentence => "She carries the load well.", :word_order => 8 },
    { :word => "donkeys", :sentence => "We rode on donkeys across the desert.", :word_order => 9 },
    { :word => "guesses", :sentence => "Which guesses were the closest to right?", :word_order => 10 },
    { :word => "pennies", :sentence => "It's raining pennies from Heaven.", :word_order => 11 },
    { :word => "preys", :sentence => "The tiger preys on other animals.", :word_order => 12 },
    { :word => "worries", :sentence => "No worries.", :word_order => 13 },
    { :word => "bodies", :sentence => "Their bodies were old and tired.", :word_order => 14 },
    { :word => "churches", :sentence => "The churches were all build around the same corner.", :word_order => 15 },
    { :word => "enjoys", :sentence => "She enjoys a good joke.", :word_order => 16 },
    { :word => "monkeys", :sentence => "As much fun as a barrel of monkeys.", :word_order => 17 },
    { :word => "plays", :sentence => "We saw two plays about relationships.", :word_order => 18 },
    { :word => "trays", :sentence => "The food trays were delicious.", :word_order => 19 }
    ]
  ],
  [
  { :title => "...ing Words", :due_date => "2012-May-02", :user_id => larry.id },
    [
    { :word => "puffing", :sentence => "We were puffing and panting after the run.", :word_order => 0 },
    { :word => "melting", :sentence => "The snow was melting, but we still built a snow fort.", :word_order => 1 },
    { :word => "sobbing", :sentence => "He was sobbing and wailing.", :word_order => 2 },
    { :word => "loading", :sentence => "The loading dock was busy with trucks coming and going.", :word_order => 3 },
    { :word => "screaming", :sentence => "The people on the roller coaster were screaming and laughing.", :word_order => 4 },
    { :word => "tugging", :sentence => "The kitten was tugging on the string.", :word_order => 5 },
    { :word => "popping", :sentence => "The corn started popping so we melted the butter.", :word_order => 6 },
    { :word => "dragging", :sentence => "He was dragging his heels.", :word_order => 7 },
    { :word => "blaming", :sentence => "There was too much blaming and not enough problem solving.", :word_order => 8 },
    { :word => "speeding", :sentence => "He got a speeding ticket.", :word_order => 9 },
    { :word => "sprinting", :sentence => "He took off sprinting across the playground.", :word_order => 10 },
    { :word => "quitting", :sentence => "There's no quitting now.", :word_order => 11 },
    { :word => "snowing", :sentence => "It was snowing very hard.", :word_order => 12 },
    { :word => "placing", :sentence => "Try placing the bowl on the picnic table.", :word_order => 13 },
    { :word => "shaping", :sentence => "She was shaping the clay with her hands.", :word_order => 14 }
    ]
  ],
].each do |word_list|
  wl = WordList.create(word_list[0])
  wl.list_items.create(word_list[1])
end 
