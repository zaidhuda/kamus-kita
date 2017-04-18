//= require jquery
//= require clipboard
//= require snackbar.min
//= require lightsaber

$(function() {
  prepareSnackbarContainer();
  activateClipboard();
  initA2A();
  $('.lightsabers').lightsaber();
});

var prepareSnackbarContainer = function() {
  if ($('#snackbar-container')[0] === undefined) {
    $('body').append("<div id='snackbar-container'></div>")
  }
}

var activateClipboard = function() {
  var snackbarOptions = {
    content: "Copied!",
    style: "toast",
    timeout: 2000
  }

  var clipboard = new Clipboard('.def-url-clipboard-btn');
  clipboard.on('success', function() {
    $.snackbar(snackbarOptions)
  })
}

var initA2A = function() {
  try {
    a2a.init_all();
  } catch (e) {}
}