class TweetBannerJob 
  include SuckerPunch::Job
  
  def perform(word_id)
    ActiveRecord::Base.connection_pool.with_connection do
      word = Word.find(word_id)
      word.tweet_banner
    end
  end
end
