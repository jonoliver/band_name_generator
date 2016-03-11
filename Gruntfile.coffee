module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-bower-install'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-gh-pages'
  
  grunt.initConfig
    watch:
      coffee:
        files: 'src/*.coffee'
        tasks: ['coffee:compile']

    coffee:
      compile:
        expand: true,
        flatten: true,
        cwd: "#{__dirname}/src/",
        src: ['*.coffee'],
        dest: 'js/',
        ext: '.js'
        
    bowerInstall:
      target:
        src: ['index.html']
        
    copy: 
      build:
        # cwd: ''
        src: [ '*.html', 'js/**', 'css/**', 'bower_components/**' ]
        dest: 'build'
        expand: true
        
    clean:    
      build:
        src: ['build']
        
    'gh-pages':
      src: ['**', '!node_modules', '!.grunt']
      options:
        base: 'build'
        
  grunt.registerTask 'build', ['coffee:compile', 'clean:build', 'copy:build']
  grunt.registerTask 'publish', ['build', 'gh-pages']