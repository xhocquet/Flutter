# Flutter

###Setup
As of 8/8/2015 this runs on the latest rails with ruby 2.2.2. Latest postgres, with a localhost server running on `localhost:5432`. Change the `database.yml` file to whateverr you have your db set up as, mine is just `xhocquet` for user and pass. 

Once your DB connects, run `db:migrate` to create the tables, `db:seed` will fill the `genres` and `animes` tables with the data I've already scraped. No need to destroy HM's bandwidth! 

Then, run `rails s` and you should be able to connect on `localhost:3000` in the browser.

###Status (11/10/2015)
I performed a major refactor for the tabbing within rails, along with a redesign of the site. I got tired of material since it looked a bit awkard on computers screens. I now just switched to a custom style I'll just be building alot the way. This site isn't really complicated enough to require super fancy css frameworks.

###To-do
* Maybe some user authentication, if only to make the admin utilities private for release
* More graphs, as described in the respective views
* Save more attributes calculated at runtime in the controller to the database. Should be lumped in with first time user operations.
* Make prettier loading screens
