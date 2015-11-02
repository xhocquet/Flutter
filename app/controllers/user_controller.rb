require 'json'

class UserController < ApplicationController

  layout "user"

  def general
    # Check if we already have info for this user. Catches error from HB if user doesn't exist
    begin
      generate_info(params[:username]) unless User.exists?(:name => params[:username])
    rescue JSON::ParserError => e
      return redirect_to :controller => 'application', :action => 'index', :err => 1
    end

    @cur_user = User.find_by_name(params[:username])
    @cur_user_list = @cur_user.library_entries
    @user_anime = @cur_user.animes
    
    @meanScore = @cur_user.mean_rating

    @db_show_count = Anime.count
    @user_show_count = @cur_user_list.count

    @db_episode_count = Anime.all.sum(:episode_count)
    @user_episode_count = @cur_user.number_of_episodes

    render :general
  end

  def library
    @cur_user = User.find_by_name(params[:username])
    @cur_user_list = @cur_user.library_entries
    @user_anime = @cur_user.animes
  end

  def ratings
    @cur_user = User.find_by_name(params[:username])
    @cur_user_list = @cur_user.library_entries
    @user_anime = @cur_user.animes

  end

  def history
    @cur_user = User.find_by_name(params[:username])
    @cur_user_list = @cur_user.library_entries
    @user_anime = @cur_user.animes

  end

  def trends
    @cur_user = User.find_by_name(params[:username])
    @cur_user_list = @cur_user.library_entries
    @user_anime = @cur_user.animes

    @chart_colors = ['#F57C00','#4CAF50','#303F9F','#FF5252','#FFC107','#7C4DFF','#03A9F4','#E040FB','#FF5722','#8BC34A']

    # GRAPH - Show status distribution
    @completed_show_count = @cur_user_list.where(:status => 'completed').count
    @on_hold_show_count = @cur_user_list.where(:status => 'on-hold').count
    @dropped_show_count = @cur_user_list.where(:status => 'dropped').count
    @watching_show_count = @cur_user_list.where(:status => 'currently-watching').count
    @plan_to_show_count = @cur_user_list.where(:status => 'plan-to-watch').count
    @show_status_array = [@watching_show_count, @plan_to_show_count, @completed_show_count, @on_hold_show_count, @dropped_show_count].to_json

    # GRAPH - Rating distribution
    @rating_count_hash = @cur_user_list.where(:status => 'completed').group(:rating).count
    @rating_count_array = @rating_count_hash.map {|i,v| [i.nil? ? 0  : (i), v]}.sort{|a,b| a<=> b}.to_json

    # GRAPH - Show count vs day completed heatmap
    @month_count_hash = @cur_user_list.where(:status => 'completed').group("DATE_TRUNC('month', last_date_watched)").count
    @month_count_array = @month_count_hash.map {|i,v| [i.month,i.year, v]}.to_json

    # GRAPH - Shows watched by air date line
    @year_count_hash = @user_anime.group("DATE_TRUNC('year', start_air_date)").count.delete_if{|i,v| i.nil?}
    @year_count_array = @year_count_hash.map {|i,v| [i.year, v]}.sort{|a,b| a<=> b}.to_json

    # GRAPH - Shows pie chart of different types (OVA, TV, etc)
    @anime_type_hash = @user_anime.group(:show_type).count
    @anime_type_array = @anime_type_hash.map {|i, v| {'name' => i, 'y' => v}}.to_json

    # GRAPH - Mean score by year line
    @score_year_hash = @cur_user_list.where("rating IS NOT NULL AND status = 'completed'").group_by{|le| le.anime.start_air_date.year}
    @score_year_array = @score_year_hash.map{|year,shows| [year, (shows.sum{|s| s.rating}/shows.count).round(3)]}.sort{|a,b| a<=> b}.to_json

    # GRAPH - Mean score by genre
    #@score_genre_hash = @cur_user_list.where.not(rating: nil).group_by{|le| le.anime.genres.name}

  end

  def refreshData
    @does_user_exist = User.exists?(:name => params[:username])
    
    if @does_user_exist
      LibraryEntry.destroy_all(name: params[:username])
      User.find_by_name(params[:username]).destroy
    end

    redirect_to :action => "general", :username=> params[:username]
  end

  #Generates our new user and saves his properties, library entries
  def generate_info(username)
    @url_library = URI.encode("http://hummingbird.me/api/v1/users/"+username+"/library")
    @url_profile = URI.encode("http://hummingbird.me/api/v1/users/"+username)
    
    @library_response = HTTParty.get(@url_library)
    @profile_response = HTTParty.get(@url_profile)

    @library_body = @library_response.body
    @profile_body = @profile_response.body
    
    @cur_user_list = JSON.parse(@library_body)
    @cur_user = JSON.parse(@profile_body)
    
    new_user = User.new
    new_user.name = @cur_user['name']
    new_user.hm_library_url = "https://hummingbird.me/users/"+ @cur_user['name'] + "/library"
    new_user.hm_dash_url = "https://hummingbird.me/users/"+ @cur_user['name']
    new_user.avatar = @cur_user['avatar']
    new_user.time_spent_on_anime = @cur_user['life_spent_on_anime']
    new_user.time_string = totalTimeString(@cur_user['life_spent_on_anime'])
    new_user.cover_image = @cur_user['cover_image']
    new_user.last_date_updated = DateTime.strptime(@cur_user['last_library_update'],'%Y-%m-%dT%H:%M:%S')
    new_user.number_of_entries,new_user.mean_rating,new_user.number_of_episodes = getMeanScore(@cur_user_list)
    new_user.save!

    # Generate each list item from JSON
    @cur_user_list.each do |index, value|
      new_library_entry = LibraryEntry.new
      new_library_entry.title = index['anime']['title']
      new_library_entry.last_date_watched = DateTime.strptime(index['last_watched'],'%Y-%m-%dT%H:%M:%S')
      new_library_entry.episodes_watched = index['episodes_watched']
      new_library_entry.times_rewatched = index['rewatched_times']
      new_library_entry.status = index['status']
      new_library_entry.rating = index['rating']['value']
      new_library_entry.hm_id = index['anime']['id']
      new_library_entry.name = new_user.name

      # Find this anime, plug it into users animes and library entry
      cur_entry_anime = Anime.where(:hm_id => index['anime']['id']).first
      new_library_entry.anime = cur_entry_anime

      new_library_entry.save!

      # Plug new library entry into anime and user
      cur_entry_anime.library_entries << new_library_entry
      new_user.library_entries << new_library_entry
    end
  end

  def totalTimeString(minutes)
    hh, mm = minutes.divmod(60)
    dd, hh = hh.divmod(24)
    mn, dd = dd.divmod(31)
    yr, mn = mn.divmod(12)

    "You've watched %d years, %d months. %d days, %d hours, and %d minutes of anime." % [yr, mn, dd, hh, mm]
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
