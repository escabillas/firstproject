class AnimesController < ApplicationController
  before_action :set_anime, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  # GET /animes or /animes.json
  def index
    @animes = Anime.all
  end

  # GET /animes/1 or /animes/1.json
  def show
  end

  # GET /animes/new
  def new
    #@anime = Anime.new
    @anime = current_user.animes.build
  end

  # GET /animes/1/edit
  def edit
  end

  # POST /animes or /animes.json
  def create
    #@anime = Anime.new(anime_params)
    @anime = current_user.animes.build(anime_params)

    respond_to do |format|
      if @anime.save
        format.html { redirect_to @anime, notice: "Anime was successfully created." }
        format.json { render :show, status: :created, location: @anime }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @anime.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animes/1 or /animes/1.json
  def update
    respond_to do |format|
      if @anime.update(anime_params)
        format.html { redirect_to @anime, notice: "Anime was successfully updated." }
        format.json { render :show, status: :ok, location: @anime }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @anime.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animes/1 or /animes/1.json
  def destroy
    @anime.destroy
    respond_to do |format|
      format.html { redirect_to animes_url, notice: "Anime was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @friend = current_user.animes.find_by(id: params[:id])
    redirect_to animes_path, notice: "Not Authorized to Edit This Anime" if @friend.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_anime
      @anime = Anime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def anime_params
      params.require(:anime).permit(:title, :animestatus, :season, :episode, :user_id)
    end
end
