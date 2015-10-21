var options = {
  valueNames: [ 'title', 'status', 'rating', 'community_rating' ],
  page: 10000
};

var userList = new List('list_container', options);

userList.sort('title', { order: "asc" });
