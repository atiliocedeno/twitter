class UsersController < ApplicationController


    def show
        tweet = Tweet.find(params[:id])
        id = tweet.user.id
        @user = User.find(id)
        @relaciones = Follow.all
        @follows = @user.follows
        @followed = @follows == []
        @followers = Follow.where(followed_id: id)
      end
  
    private
    def user_params
        params.require(:user).permit(:name, :photo)
    end
end
