class Definition < ApplicationRecord
  belongs_to :user
  belongs_to :word
  has_many :votes

  before_validation :find_or_create_word

  validates_presence_of :user_id, :word_id, :original_word, :definition, :example

  def self.best
    self.order(likes_counter: :desc).limit(1).first
  end

  def find_or_create_word
    if new_record?
      self.word = Word.friendly.find(original_word.downcase.parameterize)
    end
  rescue ActiveRecord::RecordNotFound
    self.word = Word.create!(word: original_word)
  end

  def liked_by liker
    vote = votes.find_or_initialize_by(user: liker)
    vote.like = true
    vote.save
  end

  def disliked_by disliker
    vote = votes.find_or_initialize_by(user: disliker)
    vote.like = false
    vote.save
  end
  
  def destroy
    self.update_attribute(:hidden, true)
  end
end
