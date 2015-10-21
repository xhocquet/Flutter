$( document ).ready(function() {
  $('#username_search_field').keypress(function (e) {
      if (e.which == 13) {
        e.preventDefault();
        var username = $('.username_search_field').val();
        $('.username_search_field').hide();
        window.location.href = '../user/general/' + username;
      }
  })
});
