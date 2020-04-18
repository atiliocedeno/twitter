class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @tweets =  Tweet.order(:id).page params[:page]
    @tweet = Tweet.new
    end

    def show
      @tweet = Tweet.find(params[:id])
      @user_likes = Like.all.where(tweet_id: @tweet).pluck('user_id')
    end

    def create
      @tweet = Tweet.new(tweet_params)
      @tweet.user = current_user
      respond_to do |f|
        if @tweet.save
          f.html {redirect_to root_path, notice: "Tu tweet ha sido ingresado con exito!"}
        else
          f.html {redirect_to root_path, notice: "No se ha guardado tu twwet"}
        end
      end
    end
    def retweet
      @tweet = Tweet.find(params[:id])
      redirect_to root_path, alert: 'No puede retweetear' and return if @tweet.user==current_user
      retweeteado = Tweet.new(content: @tweet.content)
      retweeteado.user = current_user
      if retweeteado.save
        @tweet.update(retweets: @tweet.retweets += 1)
        redirect_to root_path, notice: 'Has retweeteado'
      else
        redirect_to root_path, notice: 'No has retweeteado'
      end

    end

    private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
