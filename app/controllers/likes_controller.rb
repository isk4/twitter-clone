class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_tweet, only: [:create, :destroy, :set_like]
  before_action :set_like, only: [:show, :edit, :update, :destroy]

  # GET /likes
  # GET /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new
    @like.user_id = current_user.id
    @like.tweet_id = @tweet.id
  
    respond_to do |format|
      if @like.save
        format.html { redirect_to root_path, notice: "You've liked this tweet." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { redirect_to root_path }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes/1
  # PATCH/PUT /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "You've unliked this tweet." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = @tweet.likes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.fetch(:like, {})
    end

    def find_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end
end
