famousSentences = [
  '''The only people for me are the mad ones, the ones who are mad to live, mad to talk, mad to be saved, desirous of everything at the same time, the ones who never yawn or say a commonplace thing, but burn, burn, burn like fabulous yellow roman candles exploding like spiders across the stars.'''
  '''Nothing behind me, everything ahead of me, as is ever so on the road.'''
  '''What is that feeling when you’re driving away from people and they recede on the plain till you see their specks dispersing? - it’s the too-huge world vaulting us, and it’s good-bye. But we lean forward to the next crazy venture beneath the skies.'''
  '''A pain stabbed my heart, as it did every time I saw a girl I loved who was going the opposite direction in this too-big world.'''
  '''The best teacher is experience and not through someone’s distorted point of view.'''
  '''Boys and girls in America have such a sad time together; sophistication demands that they submit to sex immediately without proper preliminary talk. Not courting talk — real straight talk about souls, for life is holy and every moment is precious.'''
  '''I was surprised, as always, be how easy the act of leaving was, and how good it felt. The world was suddenly rich with possibility.'''
  '''I realized these were all the snapshots which our children would look at someday with wonder, thinking their parents had lived smooth, well-ordered lives and got up in the morning to walk proudly on the sidewalks of life, never dreaming the raggedy madness and riot of our actual lives, our actual night, the hell of it, the senseless emptiness.'''
  '''I woke up as the sun was reddening; and that was the one distinct time in my life, the strangest moment of all, when I didn’t know who I was - I was far away from home, haunted and tired with travel, in a cheap hotel room I’d never seen, hearing the hiss of steam outside, and the creak of the old wood of the hotel, and footsteps upstairs, and all the sad sounds, and I looked at the cracked high ceiling and really didn’t know who I was for about fifteen strange seconds. I wasn’t scared; I was just somebody else, some stranger, and my whole life was a haunted life, the life of a ghost.'''
  '''...because he had no place he could stay in without getting tired of it and because there was nowhere to go but everywhere, keep rolling under the stars...'''
  '''Our battered suitcases were piled on the sidewalk again; we had longer ways to go. But no matter, the road is life.'''
  '''Sal, we gotta go and never stop going ‘till we get there. Where we going, man? I don’t know but we gotta go.'''
  '''But why think about that when all the golden lands ahead of you and all kinds of unforseen events wait lurking to surprise you and make you glad you’re alive to see?'''
  '''The only people for me are the mad ones, the ones who are mad to live, mad to talk, mad to be saved.'''
  '''So in America when the sun goes down and I sit on the old broken-down river pier watching the long, long skies over New Jersey and sense all that raw land that rolls in one unbelievable huge bulge over to the West Coast, and all that road going, and all the people dreaming in the immensity of it, and in Iowa I know by now the children must be crying in the land where they let the children cry, and tonight the stars’ll be out, and don’t you know that God is Pooh Bear? the evening star must be drooping and shedding her sparkler dims on the prairie, which is just before the coming of complete night that blesses the earth, darkens all the rivers, cups the peaks and folds the final shore in, and nobody, nobody knows what’s going to happen to anybody besides the forlorn rags of growing old, I think of Dean Moriarty, I even think of Old Dean Moriarty the father we never found, I think of Dean Moriarty.'''
  '''“What do you want out of life?" I asked, and I used to ask that all the time of girls. “I don't know,“ she said. “Just wait on tables and try to get along.” She yawned. I put my hand over her mouth and told her not to yawn. I tried to tell her how excited I was about life and the things we could do together; saying that, and planning to leave Denver in two days. She turned away wearily. We lay on our backs, looking at the ceiling and wondering what God had wrought when He made life so sad.”'''
  '''My aunt once said that the world would never find peace until men fell at their women’s feet and asked for forgiveness.'''
  '''Soon it got dusk, a grapy dusk, a purple dusk over tangerine groves and long melon fields; the sun the color of pressed grapes, slashed with burgandy red, the fields the color of love and Spanish mysteries.'''
  '''I was halfway across America, at the dividing line between the East of my youth and the West of my future.'''
  '''LA is the loneliest and most brutal of American cities; NY gets god-awful cold in the winter but there’s a feeling of wacky comradeship somewhere in some streets. LA is a jungle.'''
  '''We agreed to love each other madly.'''
  '''His friends said, “Why do you have that ugly thing hanging there?” and Bull said, “I like it because it’s ugly.” All his life was in that line.'''
  '''“I just won't sleep,” I decided. There were so many other interesting things to do.'''
  '''For the first time in my life the weather was not something that touched me, that caressed me, froze or sweated me, but became me.'''
  '''Sure baby, mañana. It was always mañana. For the next few weeks that was all I heard––mañana a lovely word and one that probably means heaven.'''
  '''Ah, it was a fine night, a warm night, a wine-drinking night, a moony night, and a night to hug your girl and talk and spit and be heavengoing.'''
  '''Better to sleep in an uncomfortable bed free, than sleep in a comfortable bed unfree.'''
  '''...we all must admit that everything is fine and there’s no need in the world to worry, and in fact we should realize what it would mean to us to UNDERSTAND that we’re not REALLY worried about ANYTHING.'''
  '''As we crossed the Colorado-Utah border I saw God in the sky in the form of huge gold sunburning clouds above the desert that seemed to point a finger at me and say, “Pass here and go on, you’re on the road to heaven.”'''
]

text = KEROUAC_ON_THE_ROAD

text = text.replace /\n/g, ' '
text = text.replace /\"/g, ''
text = text.replace /\'/g, '’'
sentences = text.match /[^\.!\?]+[\.!\?]+/g

for sentence, i in sentences
  sentence = sentence.trim()
  sentences[i] = sentence.charAt(0).toUpperCase() + sentence.substr(1)

font = ->
  fontFamily: 'Gill Sans'
  fontWeight: 'normal'
  fontSize: Math.floor(Math.random() * 32) + 13

randomDarkGray = ->
  num = 130 + Math.floor(Math.random() * 20)
  "rgb(#{ num }, #{ num }, #{ num })"

randomLightGray = ->
  num = 150 + Math.floor(Math.random() * 50)
  "rgb(#{ num }, #{ num }, #{ num })"

attempts = 0
sentenceNumber = 0
sentencesToDraw = famousSentences.length

while sentenceNumber < sentencesToDraw
  drawn = Letters.draw canvas, 1,
    font: ->
      fontFamily: 'Gill Sans'
      fontWeight: 'normal'
      fontSize: Math.floor(20 * ((Math.max(0, 200 - (famousSentences[sentenceNumber].length / 2)) / 100) + 1))
    letter: -> famousSentences[sentenceNumber]
    color: randomDarkGray

  attempts += 1
  if drawn or attempts > 20
    attempts = 0
    sentenceNumber += 1

attempts = 0
sentenceNumber = 0
sentencesToDraw = Math.floor sentences.length / 2

while sentenceNumber < sentencesToDraw
  drawn = Letters.draw canvas, 1,
    font: ->
      fontFamily: 'Gill Sans'
      fontWeight: 'normal'
      fontSize: Math.floor(Math.random() * 12) + 14
    letter: -> sentences[sentenceNumber]
    color: randomLightGray

  attempts += 1
  if drawn or attempts > 20
    attempts = 0
    sentenceNumber += 1
