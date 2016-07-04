module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-gh-pages'
  
  grunt.initConfig
    watch:
      coffee:
        files: 'apps/**/*.coffee'
        tasks: ['coffee:compile']

    coffee:
      compile:
        expand: true,
        flatten: true,
        cwd: "#{__dirname}/apps",
        src: ['**/*.coffee'],
        dest: 'apps/web/node_modules',
        ext: '.js'
        
    browserify:
      'apps/web/app.js': ['apps/web/node_modules/main.js']
      'apps/web/poem.js': ['apps/web/node_modules/poem.js']
    
    uglify:
      my_target:
        files:
          'apps/web/app.js': 'apps/web/app.js'
          'apps/web/poem.js': 'apps/web/poem.js'
    
    copy: 
      build:
        cwd: 'apps/web/'
        src: [ '*.html', '*.js', 'css/**' ]
        dest: 'build'
        expand: true
        
    clean:    
      build:
        src: ['build']
        
    'gh-pages':
      src: ['**', '!node_modules', '!.grunt']
      options:
        base: 'build'
        
  grunt.registerTask 'build', ['coffee:compile', 'browserify', 'uglify', 'clean:build', 'copy:build']
  grunt.registerTask 'publish', ['build', 'gh-pages']