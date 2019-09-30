class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards

  def answer_valuenow
    return 0 if cards.none?

    (cards.where(rank: 10).count.to_f / cards.count * 100).round
  end
end
