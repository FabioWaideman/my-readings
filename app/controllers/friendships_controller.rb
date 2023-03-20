class FriendshipsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]

  def create
    @friendship = Friendship.new(user: current_user, friend: @user)
    authorize @friendship
    @friendship.save
    sleep 2
    respond_to do |format|
      format.html
      format.json { head => :no_content}
    end
  end

  def destroy
    if current_user.friends.include?(@user)
      @friendship = current_user.friendships.find_by(friend: @user)
    elsif current_user.inverse_friends.include?(@user)
      @friendship = @user.friendships.find_by(friend: current_user)
    end
    authorize @friendship
    @friendship.destroy
    respond_to do |format|
      format.html
      format.json { head => :no_content}
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
