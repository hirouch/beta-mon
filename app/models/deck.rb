class Deck < ApplicationRecord
  belongs_to :user
  has_many :posts

  def answer_valuenow
    return 0 if posts.none?

    (posts.where(rank: 10).count.to_f / posts.count * 100).round
  end
end
