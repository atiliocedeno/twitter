class ApiController < ActionController::API
    def news
        @tweets = Tweet.order('created_at').limit(50)
        tweet_f = {}
        tweets = []
        @tweets.each do |t|
            like_count = t.likes.count
            retweet_count = t.retweets
            tweet_f = {id: t.id, content: t.content, like_count: like_count, retweet_count: retweet_count}
            tweets << tweet_f
        end
        render json: tweets
    end

    def fecha
        f1 = params[:f1]
        f2 = params[:f2]
    
        arr = f1.split("")
        dia = arr[0..1].join("")
        mes = arr[2..3].join("")
        año = arr[4..-1].join("")
        fecha1 = "#{año}-#{mes}-#{dia} 00:00:00"
        fecha1.to_time.strftime("%d/%m/%Y - %H:%M:%S")
       
        arr = f2.split("")
        dia = arr[0..1].join("")
        mes = arr[2..3].join("")
        año = arr[4..-1].join("")
        fecha2 = "#{año}-#{mes}-#{dia} 23:59:59"
        fecha2.to_time.strftime("%d/%m/%Y - %H:%M:%S")
       
        results = Tweet.where('created_at >= ({fecha1}) AND created_at <= (#{fecha2})')
        @tweets = Tweet.created_between(fecha1, fecha2)
        
        render json: @tweets
    end

    def tweet
        user_api = request.headers['X-CLIENTE']
        key_user_api = request.headers['X-KEYUSER']
        if User.find_by(email: user_api) != nil
            user = User.find_by(email: user_api) 
            if user.valid_password?(key_user_api)
                content = params[:content]
                @tweet = Tweet.new
                @tweet.user = user
                @tweet.content = content
                @tweet.save
                render json: @tweet
            else
                render json: {notice: "Usuario no autenticado" }
            end
        else
            render json: {notice: "No exite el user" }
        end
    end

end