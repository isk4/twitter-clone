class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_tweet, only: [:create, :destroy, :set_like]
  before_action :set_like,   only: [:show, :edit, :update, :destroy]

  # GET /likes/new
  def new
    @like = Like.new
  end

  # POST /likes
  def create
    @like = Like.new
    @like.user_id = current_user.id
    @like.tweet_id = @tweet.id
  
    if @like.save
      redirect_to root_path, notice: "You've liked this tweet."
    else
      redirect_to root_path, notice: "There was an error liking this tweet."
    end
  end

  # DELETE /likes/1
  def destroy
    @like.destroy
    redirect_to root_path, notice: "You've unliked this tweet."
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
