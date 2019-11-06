class ArtistsController < ApplicationController

  before_action :set_preferences, only: [:index, :new]

  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    if @preferences && !@preferences.allow_create_artists
      redirect_to artists_path
    else
      @artist = Artist.new
  end
end

  def create
  end

  def artist_params
    params.require(:artist).permit(:name)
  end

  def set_preferences
    @preferences = Preference.first
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    @artist.update(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end
