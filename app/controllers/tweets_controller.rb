class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :set_page, only: [:index]
  before_action :find_reference, only: [:new, :create]
  before_action :new_friend, only: [:index, :show]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweet = Tweet.new
    if params[:search].present?
      @tweets = Tweet.search_for(params[:search])
    else
      @tweets = user_signed_in? ? Tweet.tweets_for_me(current_user.friends, @page) : Tweet.all.order(id: :desc)
    end
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
    redirect_to tweets_path, notice: "Oops! You're not supposed to do that." unless @tweet.user_id == current_user.id
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.retweet_from_id = @reference.id unless @reference.nil?

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { redirect_to tweets_url, alert: 'Tweet must have content.' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:user_id, :content, :retweet_from_id)
    end

    def set_page
      @page = params[:page].nil? ? 1 : params[:page].to_i
    end

    def find_reference
      @reference = Tweet.find(params[:reference]) unless params[:reference].nil?
    end

    def new_friend
      @friend = Friend.new
    end
end
