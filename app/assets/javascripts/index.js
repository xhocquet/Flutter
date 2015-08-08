
//TODO = Sanitize input
$( document ).ready(function() {
  $('#username-search-form').submit(function(e){
    e.preventDefault();
    var username = $('.index-username-search').val();
    window.location.href = '../user/' + username;
  }); 
});