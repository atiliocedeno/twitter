module TweetsHelper
    def render_with_hashtag(content)
        content.gsub(/#\w+/){|w|link_to w, "tweets/hashtags/#{w.delete('#')}"}.html_safe 
    end
end
