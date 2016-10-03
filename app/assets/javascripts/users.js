$(document).ready(function() {
    $('select').material_select();
  });


  $(document).ready(function(){
    $('.modal-trigger').leanModal();
});
// Show sideNav
 $('.button-collapse').sideNav('show');
 // Hide sideNav
 $('.button-collapse').sideNav('hide');

$(".dropdown-button").dropdown();
$(".button-collapse").sideNav();


$(document).ready(function() {
  $('input#input_text, textarea#textarea1').characterCounter();
});
