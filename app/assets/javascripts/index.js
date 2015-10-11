
//TODO = Sanitize input
$( document ).ready(function() {
  $('#username_search_form').submit(function(e){
    e.preventDefault();
    var username = $('.username_search_field').val();
    alert(username);
    $('form').hide();
    window.location.href = '../user/' + username;
  }); 
});
