# Random words
Word = (collection, filter = _.noop()) -> _.chain(collection).filter(filter).sample().default("butt").cap().value()
Alliteration = (word, type = Noun) -> type((w) -> w.charAt(0).toLowerCase() == word.charAt(0).toLowerCase())
Noun = (filter) -> Word(nouns, filter)
SingularNoun = (filter) -> Word(singular_nouns, filter)
PluralNoun = (filter) -> Word(plural_nouns, filter)
ShortNoun = (filter) -> Word(_(singular_nouns).filter((w) -> w.length < 7), filter)
TinyNoun = (filter) -> Word(_(singular_nouns).filter((w) -> w.length < 4), filter)
Verb = (filter) -> Word(verbs, filter)
Verber = (filter) -> Word(verbers, filter)
Gerund = (filter) -> Word(gerunds, filter)
Adjective = (filter) -> Word(adjectives, filter)
Preposition = (filter) -> Word(prepositions, filter)

# Conditional Words
An_A = (w) -> "#{if starts_with_vowel w then 'An' else 'A'} #{w}"
Random_The = -> if random_bool() then "The " else ""

# helpers
starts_with_vowel = (w) -> w.match(/^[aeiou]/i)
random_bool = -> Math.random() >= 0.5

NameTypes =
  verber:                   -> "#{Verber()}"
  noun_verber:              -> "#{ShortNoun()}#{Verber().toLowerCase()}"
  noun_noun:                -> "#{ShortNoun()}#{ShortNoun().toLowerCase()}"
  of_noun_and_noun:         -> "Of #{PluralNoun()} And #{PluralNoun()}"
  as_the_nouns_verb:        -> "As #{Random_The()}#{PluralNoun()} #{Verb()}"
  when_the_nouns_verb:      -> "When #{Random_The()}#{PluralNoun()} #{Verb()}"
  a_noun_to_verb:           -> "#{An_A SingularNoun()} To #{Verb()}"
  noun_of_the_noun:         -> "#{Noun()} Of #{Random_The()}#{Noun()}"
  verber_of_the_noun:       -> "#{Verber()} Of #{Random_The()}#{Noun()}"
  verb_the_noun:            -> "#{Verb()} The #{Noun()}"
  gerund_the_noun:          -> "#{Gerund()} The #{Noun()}"
  the_gerund_noun:          -> "#{Random_The()}#{Gerund()} #{Noun()}"
  the_adjective_noun:       -> "#{Random_The()}#{Adjective()} #{Noun()}"
  allit_adjective_noun:     -> n=Noun(); "#{Alliteration n, Adjective} #{n}"
  allit_noun_noun:          -> n=ShortNoun(); "#{Alliteration n, ShortNoun} #{n}"
  short_allit_noun_noun:    -> n=ShortNoun(); "#{Alliteration n, TinyNoun}#{n.toLowerCase()}"
  preposition_the_noun:     -> "#{Preposition()} The #{Noun()}"
  preposition_my_noun:      -> "#{Preposition()} My #{Noun()}"
  preposition_nouns:        -> "#{Preposition()} #{PluralNoun()}"
  preposition_this_noun:    -> "#{Preposition()} This #{SingularNoun()}"
  preposition_these_nouns:  -> "#{Preposition()} These #{PluralNoun()}"
  gerund_preposition_nouns: -> "#{Gerund()} #{Preposition()} #{PluralNoun()}"
  with_nouns_we_verb:       -> "With #{PluralNoun()} We #{Verb()}"
  from_nouns:       -> "From #{PluralNoun()}"
  # gerund_preposition:       -> "#{Gerund()} #{Preposition()}"
console.log NameTypes.allit_adjective_noun()
console.log NameTypes.allit_noun_noun()
console.log NameTypes.short_allit_noun_noun()
#gerund_for_nouns
RandomName = ->  
  random = _(Object.keys(NameTypes)).sample()
  NameTypes[random]()

RandomNames = (limit=10) ->
  _([1..limit]).map -> RandomName()
  
RandomizeAll = ->
  _(_.shuffle(Object.keys(NameTypes))).map (key) -> NameTypes[key]()

$(document).ready ->
  $('#generate').click ->
    li = _(RandomizeAll()).map (name) -> "<li>#{name}</li>"
    $('#results').html(li)
