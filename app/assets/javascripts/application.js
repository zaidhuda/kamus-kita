// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require password-generator
//= require clipboard
//= require snackbar.min
//= require lightsaber
//= require foundation.core
//= require foundation.dropdownMenu
//= require foundation.util.keyboard
//= require foundation.util.box
//= require foundation.util.mediaQuery
//= require foundation.util.nest

$(document).on('turbolinks:load ready', function() {
  $(document).foundation();
  passwordGen();
  prepareSnackbarContainer();
  activateClipboard();
  initA2A();
  $('.lightsabers').lightsaber();
});

var passwordGen = function() {
  $('.generate-random-password').on('click', function() {
    var generated_password = generatePassword(16, 16);
    $('#user_password').val(generated_password);
    $('#user_password').attr({ type: "text" });
    $('#user_password_confirmation').val(generated_password);
    console.log(generated_password)
  })

  $('#user_password').on('blur', function() {
    $('#user_password').attr({ type: "password" });
  })
}

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

  var defClipboard = new Clipboard('.def-url-clipboard-btn');
  defClipboard.on('success', function() {
    $.snackbar(snackbarOptions)
  })

  var embedClipboard = new Clipboard('.embed-code-btn');
  embedClipboard.on('success', function() {
    $.snackbar(snackbarOptions)
  })
}

var initA2A = function() {
  try {
    a2a.init_all();
  } catch (e) {}
}
