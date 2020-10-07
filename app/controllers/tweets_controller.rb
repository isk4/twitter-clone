class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :api_news, :api_dates]
  before_action :set_tweet,          only: [:show, :edit, :update, :destroy]
  before_action :set_page,           only: [:index]
  before_action :find_reference,     only: [:new, :create]
  before_action :new_friend,         only: [:index, :show]
  
  protect_from_forgery with: :null_session

  # GET /tweets
  def index
    @tweet = Tweet.new
    if params[:search].present?
      @tweets = Tweet.search_for(params[:search]).desc.page(@page)
    elsif user_signed_in?
      unless current_user.friends.empty?
        @tweets = Tweet.tweets_for_me(current_user.friends).desc.page(@page)
      else
        @tweets = current_user.tweets.desc.page(@page)
      end
    else
      @tweets = Tweet.desc.page(@page)
    end
  end

  # GET /tweets/1
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
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.retweet_from_id = @reference.id unless @reference.nil?

    if @tweet.save
      redirect_to root_path, notice: 'Your tweet was successfully created.'
    else
      redirect_to tweets_url, notice: 'Your tweet must have content.'
    end
  end

  # PATCH/PUT /tweets/1
  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: 'Your tweet was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet.destroy
    redirect_to tweets_url, notice: 'Your tweet was successfully destroyed.'
  end

  # API methods
  # GET /api/news
  def api_news
    @tweets = Tweet.desc.limit(50)

    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Oops! You shouldn't be doing that." }
      format.json { render :api_news }
    end
  end

  # GET /api/:fecha1/:fecha2
  def api_dates
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Oops! You shouldn't be doing that." }
      begin
        date1 = Date.parse(params[:fecha1])
        date2 = Date.parse(params[:fecha2])
        @tweets = Tweet.between_dates(date1, date2).desc
        format.json { render :api_dates }
      rescue ArgumentError
        format.json { render json: "Invalid dates." }
      end
    end
  end

  # GET /api/create_tweet/:content
  def api_create
    @tweet = Tweet.new(user_id: current_user.id, content: params[:content])

    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Oops! You shouldn't be doing that." }
      if @tweet.save
        format.json { render :show, status: :created, location: @tweet }
      end
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
