(function() {
  var Adjective, Alliteration, An_A, Gerund, NameTypes, Noun, PluralNoun, Preposition, RandomName, RandomNames, Random_The, RandomizeAll, ShortNoun, SingularNoun, TinyNoun, Verb, Verber, Word, random_bool, starts_with_vowel;

  Word = function(collection, filter) {
    if (filter == null) {
      filter = _.noop();
    }
    return _.chain(collection).filter(filter).sample()["default"]("butt").cap().value();
  };

  Alliteration = function(word, type) {
    if (type == null) {
      type = Noun;
    }
    return type(function(w) {
      return w.charAt(0).toLowerCase() === word.charAt(0).toLowerCase();
    });
  };

  Noun = function(filter) {
    return Word(nouns, filter);
  };

  SingularNoun = function(filter) {
    return Word(singular_nouns, filter);
  };

  PluralNoun = function(filter) {
    return Word(plural_nouns, filter);
  };

  ShortNoun = function(filter) {
    return Word(_(singular_nouns).filter(function(w) {
      return w.length < 7;
    }), filter);
  };

  TinyNoun = function(filter) {
    return Word(_(singular_nouns).filter(function(w) {
      return w.length < 4;
    }), filter);
  };

  Verb = function(filter) {
    return Word(verbs, filter);
  };

  Verber = function(filter) {
    return Word(verbers, filter);
  };

  Gerund = function(filter) {
    return Word(gerunds, filter);
  };

  Adjective = function(filter) {
    return Word(adjectives, filter);
  };

  Preposition = function(filter) {
    return Word(prepositions, filter);
  };

  An_A = function(w) {
    return (starts_with_vowel(w) ? 'An' : 'A') + " " + w;
  };

  Random_The = function() {
    if (random_bool()) {
      return "The ";
    } else {
      return "";
    }
  };

  starts_with_vowel = function(w) {
    return w.match(/^[aeiou]/i);
  };

  random_bool = function() {
    return Math.random() >= 0.5;
  };

  NameTypes = {
    verber: function() {
      return "" + (Verber());
    },
    noun_verber: function() {
      return "" + (ShortNoun()) + (Verber().toLowerCase());
    },
    noun_noun: function() {
      return "" + (ShortNoun()) + (ShortNoun().toLowerCase());
    },
    of_noun_and_noun: function() {
      return "Of " + (PluralNoun()) + " And " + (PluralNoun());
    },
    as_the_nouns_verb: function() {
      return "As " + (Random_The()) + (PluralNoun()) + " " + (Verb());
    },
    when_the_nouns_verb: function() {
      return "When " + (Random_The()) + (PluralNoun()) + " " + (Verb());
    },
    a_noun_to_verb: function() {
      return (An_A(SingularNoun())) + " To " + (Verb());
    },
    noun_of_the_noun: function() {
      return (Noun()) + " Of " + (Random_The()) + (Noun());
    },
    verber_of_the_noun: function() {
      return (Verber()) + " Of " + (Random_The()) + (Noun());
    },
    verb_the_noun: function() {
      return (Verb()) + " The " + (Noun());
    },
    gerund_the_noun: function() {
      return (Gerund()) + " The " + (Noun());
    },
    the_gerund_noun: function() {
      return "" + (Random_The()) + (Gerund()) + " " + (Noun());
    },
    the_adjective_noun: function() {
      return "" + (Random_The()) + (Adjective()) + " " + (Noun());
    },
    allit_adjective_noun: function() {
      var n;
      n = Noun();
      return (Alliteration(n, Adjective)) + " " + n;
    },
    allit_noun_noun: function() {
      var n;
      n = ShortNoun();
      return (Alliteration(n, ShortNoun)) + " " + n;
    },
    short_allit_noun_noun: function() {
      var n;
      n = ShortNoun();
      return "" + (Alliteration(n, TinyNoun)) + (n.toLowerCase());
    },
    preposition_the_noun: function() {
      return (Preposition()) + " The " + (Noun());
    },
    preposition_my_noun: function() {
      return (Preposition()) + " My " + (Noun());
    },
    preposition_nouns: function() {
      return (Preposition()) + " " + (PluralNoun());
    },
    preposition_this_noun: function() {
      return (Preposition()) + " This " + (SingularNoun());
    },
    preposition_these_nouns: function() {
      return (Preposition()) + " These " + (PluralNoun());
    },
    gerund_preposition_nouns: function() {
      return (Gerund()) + " " + (Preposition()) + " " + (PluralNoun());
    },
    with_nouns_we_verb: function() {
      return "With " + (PluralNoun()) + " We " + (Verb());
    },
    from_nouns: function() {
      return "From " + (PluralNoun());
    }
  };

  console.log(NameTypes.allit_adjective_noun());

  console.log(NameTypes.allit_noun_noun());

  console.log(NameTypes.short_allit_noun_noun());

  RandomName = function() {
    var random;
    random = _(Object.keys(NameTypes)).sample();
    return NameTypes[random]();
  };

  RandomNames = function(limit) {
    var i, results;
    if (limit == null) {
      limit = 10;
    }
    return _((function() {
      results = [];
      for (var i = 1; 1 <= limit ? i <= limit : i >= limit; 1 <= limit ? i++ : i--){ results.push(i); }
      return results;
    }).apply(this)).map(function() {
      return RandomName();
    });
  };

  RandomizeAll = function() {
    return _(_.shuffle(Object.keys(NameTypes))).map(function(key) {
      return NameTypes[key]();
    });
  };

  $(document).ready(function() {
    return $('#generate').click(function() {
      var li;
      li = _(RandomizeAll()).map(function(name) {
        return "<li>" + name + "</li>";
      });
      $('#results').html(li);
      return ga('send', 'event', 'generate', 'click');
    });
  });

}).call(this);
