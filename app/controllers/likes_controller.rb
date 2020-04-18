class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @like = Like.create(tweet: @tweet, user: current_user, like: true)
    if @like.save
      redirect_to root_path, notice: 'Like'
    else
      redirect_to root_path, alert: 'no pudiste dar like'
    end
  end
  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @like = Like.find_by(tweet: @tweet, user: current_user, like: true)
    if  !@like.blank?
      #@like.exists?(user_id: current_user.id, tweet_id: @tweet.id, like: true)
      @like.destroy
      redirect_to root_path, notice: 'no te gusta'
    else
      redirect_to root_path, alert: 'no pudiste quitar el like'
    end
  end
end
