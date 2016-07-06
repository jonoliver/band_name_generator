var webpack = require('webpack');

var commonsPlugin =
new webpack.optimize.CommonsChunkPlugin('./apps/web/js/common.js');

module.exports = {
  entry: {
    band: './apps/web/band_names/index.coffee',
    poem: './apps/web/poem/index.coffee'
  },
  output: {
    path: './apps/web',
    publicPath: '/js/',
    filename: './apps/web/js/[name].js'
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee-loader" },
      { test: /\.(coffee\.md|litcoffee)$/, loader: "coffee-loader?literate" }
    ]
  },
  resolve: {
    extensions: ["", ".webpack.js", ".web.js", ".js", ".coffee"]
  },
  plugins: [commonsPlugin]
};