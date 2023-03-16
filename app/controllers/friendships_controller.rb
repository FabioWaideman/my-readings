class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(user: current_user, friend: User.find(params[:user_id]))
    authorize @friendship
    @friendship.save
    redirect_to current_user, status: :see_other
  end

  def destroy
    @user = User.find(params[:user_id])
    if current_user.friends.include?(@user)
      @friendship = current_user.friendships.find_by(friend: @user)
    elsif current_user.inverse_friends.include?(@user)
      @friendship = @user.friendships.find_by(friend: current_user)
    end
    authorize @friendship
    @friendship.destroy
    redirect_to current_user, status: :see_other
  end
end
