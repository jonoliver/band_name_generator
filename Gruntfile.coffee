module.exports = (grunt) ->

  require('matchdep').filterAll('grunt-*').forEach grunt.loadNpmTasks
  webpack = require('webpack')
  webpackConfig = require('./webpack.config.js')
  
  grunt.initConfig
    webpack:
      options: webpackConfig
      build: plugins:
        webpackConfig.plugins.concat(
          new (webpack.DefinePlugin)('process.env': 'NODE_ENV': JSON.stringify('production')),
          new (webpack.optimize.DedupePlugin),
          new (webpack.optimize.UglifyJsPlugin))
      'build-dev':
        devtool: 'sourcemap'
        debug: true
    'webpack-dev-server':
      options:
        webpack: webpackConfig
        publicPath: '/' + webpackConfig.output.publicPath # TODO: fix this
      start:
        keepAlive: true
        webpack:
          devtool: 'eval'
          debug: true
    watch: app:
      files: [
        'apps/**/*'
        'apps/node_modules/**/*'
        # 'web_modules/**/*'
      ]
      tasks: [ 'webpack:build-dev' ]
      options: spawn: false

    copy: 
      build:
        cwd: 'apps/web/'
        src: [ '**/*.html', 'js/*.js', 'css/**' ]
        dest: 'build'
        expand: true
        
    clean:    
      build:
        src: ['build']

    'gh-pages':
      src: ['**', '!node_modules', '!.grunt']
      options:
        base: 'build'

  # The development server (the recommended option for development)
  grunt.registerTask 'default', [ 'webpack-dev-server:start' ]
  # Build and watch cycle (another option for development)
  # Advantage: No server required, can run app from filesystem
  # Disadvantage: Requests are not blocked until bundle is available,
  #               can serve an old app on too fast refresh
  grunt.registerTask 'dev', [
    'webpack:build-dev'
    'watch:app'
  ]
  
  # Production build
  grunt.registerTask 'build', ['webpack:build', 'clean:build', 'copy:build']
  grunt.registerTask 'publish', ['build', 'gh-pages']
  return
