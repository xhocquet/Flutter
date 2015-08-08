require 'json'

class UserController < ApplicationController

    layout "user"

  def show
    # Check if we already have info for this user
    @doesUserExist = User.exists?(:name => params[:uid])

    @cur_userList
    @cur_user
    @cur_animeLibrary

    if(!@doesUserExist) # User does not exist. Fetch his data via api, parse, and save
      @url_library = URI.encode("http://hummingbird.me/api/v1/users/"+params[:uid]+"/library")
      @url_profile = URI.encode("http://hummingbird.me/api/v1/users/"+params[:uid])
      
      @library_response = HTTParty.get(@url_library)
      @profile_response = HTTParty.get(@url_profile)

      @library_body = @library_response.body
      @profile_body = @profile_response.body
      
      @cur_userList = JSON.parse(@library_body)
      @cur_user = JSON.parse(@profile_body)
      
      new_user = User.new
      new_user.name = @cur_user['name']
      new_user.avatar = @cur_user['avatar']
      new_user.time_spent_on_anime = @cur_user['life_spent_on_anime']
      new_user.cover_image = @cur_user['cover_image']
      new_user.last_date_updated = DateTime.strptime(@cur_user['last_library_update'],'%Y-%m-%dT%H:%M:%S')
      new_user.number_of_entries,new_user.mean_rating,new_user.number_of_episodes = getMeanScore(@cur_userList)
      new_user.save

      # Generate each list item from JSON
      @cur_userList.each do |index, value|
        new_library_entry = LibraryEntry.new
        new_library_entry.title = index['anime']['title']
        new_library_entry.slug = index['anime']['slug']
        new_library_entry.last_date_watched = DateTime.strptime(index['last_watched'],'%Y-%m-%dT%H:%M:%S')
        new_library_entry.episodes_watched = index['episodes_watched']
        new_library_entry.times_rewatched = index['rewatched_times']
        new_library_entry.status = index['status']
        new_library_entry.rating = index['rating']['value']
        new_library_entry.name = new_user.name
        new_library_entry.save

        # Find this anime, plug it into users animes and library entry
        cur_entry_anime = Anime.where(:slug => new_library_entry  .slug).first()
        new_library_entry.anime = cur_entry_anime

        new_library_entry.save

        # Plug new library entry into anime and user
        cur_entry_anime.library_entries << new_library_entry
        new_user.library_entries << new_library_entry
      end
    end

    @cur_user = User.find_by_name(params[:uid])
    @cur_userList = @cur_user.library_entries
    @user_anime = @cur_user.animes

    @timeString = totalTimeString(@cur_user.time_spent_on_anime)
    @dashboardURL,@libraryURL = getProfileURLs(@cur_user['name'])
    @numEntries = @cur_user.number_of_entries
    @meanScore = @cur_user.mean_rating
    @episodesWatched = @cur_user.number_of_episodes

    #Material color scheme to use for charts
    @chart_colors = ['#F57C00','#4CAF50','#303F9F','#FF5252','#FFC107','#7C4DFF','#03A9F4','#E040FB','#FF5722','#8BC34A']

    # GRAPH - Show status distribution
    @completed_show_count = @cur_userList.where(:status => 'completed').count
    @on_hold_show_count = @cur_userList.where(:status => 'on-hold').count
    @dropped_show_count = @cur_userList.where(:status => 'dropped').count
    @watching_show_count = @cur_userList.where(:status => 'currently-watching').count
    @plan_to_show_count = @cur_userList.where(:status => 'plan-to-watch').count
    @show_status_array = [@watching_show_count, @plan_to_show_count, @completed_show_count, @on_hold_show_count, @dropped_show_count].to_json

    # GRAPH - Rating distribution
    @rating_count_hash = @cur_userList.where(:status => 'completed').group(:rating).count
    @rating_count_array = @rating_count_hash.map {|i,v| [i.nil? ? (null) : (i), v]}.sort{|a,b| a<=> b}.to_json

    # GRAPH - Show count vs month aired
    @month_count_hash = @cur_userList.where(:status => 'completed').group("DATE_TRUNC('month', last_date_watched)").count
    @month_count_array = @month_count_hash.map {|i,v| [i.month,i.year, v]}.to_json

    # GRAPH - Shows watched by air date line
    @year_count_hash = @user_anime.group("DATE_TRUNC('year', start_air_date)").count.delete_if{|i,v| i.nil?}
    @year_count_array = @year_count_hash.map {|i,v| [i.year, v]}.sort{|a,b| a<=> b}.to_json

      
    # TRENDS ===============
    

    # DATA/STATS TO GET
    # Main User Tab
    # => Favorite with links @user.favorites[x]
    # Anime List
    # => Completion @userList[0].status
    # => Score @userList[0].rating.value
    # => Community rating @userlist[0].anime.community_rating
    # Ratings
    # => Rating Distribution - Count by rating, map counts to rating
    # => Ratings vs Time Spent - Sum time by rating, map summed time to rating
    # => Rating vs Episode Count - Bar graph # title within episode count ranges. Then 
    # =>    line graph over it for mean rating per range
    # History
    # => Recent - Plot last month or so with # episodes or time per day. see if you can get weekdays in. 
    # =>    # separate titles in time period, total episodes last month, total time
    # => Completion by month - Rectangle darkness grid for year-month - meh
    # Trends
    # => Favorite time periods - Graph mean score by by years/decades @userList[0].anime.started_airing
    # => Favorite types - Pie chart @userlist[0].anime.show_type
    # => Airing vs Completed vs not yet
    # => Favorite genres @userList[0].anime.genres[]
    # => Favorite age ratings @userlist[0].anime.age_rating
    # => Favorite lengths?


    render layout: "user"
  end

  def getListSave

  end

  def totalTimeString(minutes)
    hh, mm = minutes.divmod(60)
    dd, hh = hh.divmod(24)
    mn, dd = dd.divmod(30)
    yr, mn = mn.divmod(12)

    "You've watched %d years, %d months. %d days, %d hours, and %d minutes of anime." % [yr, mn, dd, hh, mm]
  end

  def getProfileURLs(userName)
    @profile = "https://hummingbird.me/users/"+userName
    @library = @profile+"/library"

    return @profile,@library
  end

  def getMeanScore(animeList)
    @sum = 0
    @count = 0
    @epCount = 0

    animeList.each do |a|
        @sum += a['rating']['value'].to_f
        @count += 1
        @epCount += a['episodes_watched']
    end
    return @count,(@sum/@count).round(2),@epCount
  end

end
