_.mixin 
  cap: (string) ->
    string.charAt(0).toUpperCase() + string.substring(1).toLowerCase()
  default: (string, def_val) -> 
    if (string == undefined || string == null) then def_val else string
