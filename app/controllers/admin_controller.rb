require 'json'

class AdminController < ApplicationController

  def index
    @admin_message = "index"
    render layout: "admin"
  end

  def importAnime
    for i in 1..12000
      @anime_url = URI.encode("http://hummingbird.me/api/v1/anime/"+i.to_s)
      @anime_response = HTTParty.get(@anime_url)
      @anime_data = @anime_response.body      
      @cur_anime = JSON.parse(@anime_data)

      if(!Anime.exists?(:hm_id => @cur_anime['id']))
        if(@cur_anime.count > 1)
          new_anime = Anime.new
          new_anime.hm_id = @cur_anime['id']
          new_anime.mal_id = @cur_anime['mal_id']
          new_anime.status = @cur_anime['status']
          new_anime.hm_url = @cur_anime['url']
          new_anime.title = @cur_anime['title']
          new_anime.slug = @cur_anime['slug']
          new_anime.episode_count = @cur_anime['episode_count']
          new_anime.episode_length = @cur_anime['episode_length']
          new_anime.cover_image_url = @cur_anime['cover_image']
          new_anime.show_type = @cur_anime['show_type']
          new_anime.synopsis = @cur_anime['synopsis']
          new_anime.community_rating = @cur_anime['community_rating']
          new_anime.age_rating = @cur_anime['age_rating']
          new_anime.end_air_date = @cur_anime['finished_airing']
          new_anime.start_air_date = @cur_anime['started_airing']
          new_anime.save
        end
      end
    end

    @admin_message = "Anime database updated."

    render layout: "admin/index"
  end

  def importGenres
    Anime.all.each do |anime|
      unless anime.genres.count > 0
        @anime_url = URI.encode("http://hummingbird.me/api/v1/anime/"+anime.hm_id.to_s)
        @anime_response = HTTParty.get(@anime_url)
        @anime_data = @anime_response.body      
        @cur_anime = JSON.parse(@anime_data)
        if @cur_anime and @cur_anime['genres'].count > 0
          @cur_anime['genres'].each do |genre|
            puts "Adding " + genre['name'] + " to " + anime.slug
            @cur_genre = Genre.find_by_name(genre['name'])
            if @cur_genre
              anime.genres << @cur_genre
            else
              @temp = Genre.create(name: genre['name'])
              anime.genres << @temp
            end
          end
        end
      end
    end

    @admin_message = "Genres imported!"

    render layout: "admin/index"
  end

  def clearUserDB
    User.delete_all
    @admin_message = "User database cleared."

    render :index
  end

  def clearAnimeDB
    Anime.delete_all
    @admin_message = "Anime database cleared."

    render :index
  end

  def clearEntryDB
    LibraryEntry.delete_all
    @admin_message = "Library entries cleared."

    render :index
  end

  def updateFinishedShows
    #TODO
  end

end
