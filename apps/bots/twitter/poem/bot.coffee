app = require 'poem'
poem = app.RandomizeAll()
poem.shift() until poem.join('\n').length <= 140
console.log poem
console.log poem.join('\n').length

TwitterBot = require("node-twitterbot").TwitterBot
Bot = new TwitterBot("#{__dirname}/config.json")
Bot.tweet(poem.join('\n'));