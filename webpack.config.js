var webpack = require('webpack');

var commonsPlugin =
new webpack.optimize.CommonsChunkPlugin('common.js');

module.exports = {
  entry: {
    band: './apps/web/main.coffee',
    poem: './apps/web/poem.coffee'
  },
  output: {
    path: '.',
    filename: '[name].js'
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee-loader" },
      { test: /\.(coffee\.md|litcoffee)$/, loader: "coffee-loader?literate" }
    ]
  },
  plugins: [commonsPlugin]
};