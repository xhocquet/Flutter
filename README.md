# Flutter

###Setup
As of 8/8/2015 this runs on the latest rails with ruby 2.2.2. Latest postgres, with a localhost server running on `localhost:5432`. Change the `database.yml` file to whateverr you have your db set up as, mine is just `xhocquet` for user and pass. 

Once your DB connects, run `db:migrate` to create the tables, `db:seed` will fill the `genres` and `animes` tables with the data I've already scraped. No need to destroy HM's bandwidth! 

Then, run `rails s` and you should be able to connect on `localhost:3000` in the browser.

###Status (8/8/2015)
I haven't gotten around to making the input for the user to actually go to his page. I've been going to `home_url/meesles` to test stuff. 

`secret/admin/page` is a temp utility URL for clearing databases. To get genres working to hack on, you need to click the Import Genres button, which will check all the shows for their genres and link them up properly. This needs to be also saved in the DB seeding at some point.

I'm currently continuing on the graphs for the user page and I'll be hopping around depending on what I'm feeling!

###To-do
* Maybe some user authentication, if only to make the admin utilities private for release
* More graphs, as described in user controller
* Front door so user can just type their name in
* Save more attributes calculated at runtime in the controller to the database. Should be lumped in with first time user operations.
* Make prettier loading screens
* Do something about the title looking like crap (and needs to link back to home)
* Logo?
* Lots and lots of basic refactoring...
