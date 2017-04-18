$.fn.lightsaber = function() {
  $.each(this, function(i, lightsaber) {
    var total = $(lightsaber).data('value');
    var lightsaberBars = $(lightsaber).children('.lightsaber-bar');
    $.each(lightsaberBars, function(i, bar) {
      var value = $(bar).data('value');
      $(bar).css({width: (100.0*value/total)+"%"})
    })
  })
};