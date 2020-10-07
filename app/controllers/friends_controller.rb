class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  def new
    @friend = Friend.new
  end

  # POST /friends
  def create
    @friend = Friend.new(friend_params)
    @friend.user_id = current_user.id

    if @friend.save
      redirect_to tweets_path, notice: 'Following!'
    else
      redirect_to tweets_path, notice: "There was an error while trying to follow this user."
    end
  end

  # DELETE /friends/1
  def destroy
    @friend.destroy
    redirect_to tweets_path, notice: 'Unfollowed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:user_id, :friend_id)
    end
end
