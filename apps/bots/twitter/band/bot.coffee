app = require 'band_names'
bandName = app.RandomName()
console.log bandName

TwitterBot = require("node-twitterbot").TwitterBot
Bot = new TwitterBot("#{__dirname}/config.json")
Bot.tweet(bandName);
