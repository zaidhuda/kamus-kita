class GenerateBannerJob 
  include SuckerPunch::Job
  
  def perform(word_id)
    ActiveRecord::Base.connection_pool.with_connection do
      word = Word.find(word_id)
      word.generate_banner
    end
  end
end
