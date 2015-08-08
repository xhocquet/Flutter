$( document ).ready(function() {
  //For admin page....for some reason
  $('.admin-load-bar').hide();
  
  $('.admin-button').on('click', function(e) {
    $('.admin-button').off();
    $('form').hide();
    $('.admin-announcement').hide();
    $('.admin-load-bar').show();
  });
});