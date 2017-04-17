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

$(document).on('turbolinks:load', function() {
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

  try {
    a2a.init_all();
  } catch (e) {}
});