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
//= require jquery2
//= require jquery_ujs
//= require materialize-sprockets
//= require materialize/extras/nouislider
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  $('select').material_select();
});

$("#flash_notice").delay(5000).fadeOut("slow");
$("#flash_alert").delay(5000).fadeOut("slow");
$("#flash_error").delay(5000).fadeOut("slow");

$(document).ready(function(){
    $('.tooltipped').tooltip({delay: 50});
  });

$(document).ready(function(){
      $('.parallax').parallax();
    });

$(document).ready(function() {
  $('input#input_text, textarea#textarea1').characterCounter();
});

$(".button-collapse").sideNav();
