class FriendshipsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]

  def create
    @friendship = Friendship.new(user: current_user, friend: @user)
    authorize @friendship
    @friendship.save
    sleep 2
    redirect_to @user, status: :see_other
  end

  def destroy
    if current_user.friends.include?(@user)
      @friendship = current_user.friendships.find_by(friend: @user)
    elsif current_user.inverse_friends.include?(@user)
      @friendship = @user.friendships.find_by(friend: current_user)
    end
    authorize @friendship
    @friendship.destroy
    redirect_to current_user, status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
