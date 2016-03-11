(function() {
  _.mixin({
    cap: function(string) {
      return string.charAt(0).toUpperCase() + string.substring(1).toLowerCase();
    },
    "default": function(string, def_val) {
      if (string === void 0 || string === null) {
        return def_val;
      } else {
        return string;
      }
    }
  });

}).call(this);
