class MoviesController < ApplicationController
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id)# look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    
  end
  


  def index
    @movies = Movie.order(params[:sort])
    if params[:sort] == 'title'
      @title_header = 'hilite'
    elsif params[:sort] == 'release_date'
      @release_date_header ='hilite'
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def search_tmdb
    flash[:warning] = "'#{params[:search_terms]}' was not found in TMDb."
  redirect_to movies_path
  end
  
  
  def same_director
    @movie = Movie.find(params[:id])
    director_name = @movie.director
    
    if not director_name or director_name.empty?
      flash[:notice] = %Q{'#{@movie.title}' has no director info}
      redirect_to movies_path
    else
      @movie = Movie.find_all_by_director director_name
      flash[:notice] = %Q{There are #{@movies.size} movie(s) with "#{director_name}" as director}
    end
  end
  
 
end
