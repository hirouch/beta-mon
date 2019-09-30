class Card < ApplicationRecord
  belongs_to :user

  def self.csv_attributes
    ["question", "answer", "created_at", "updated_at", "rank", "genres"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |post|
        csv << csv_attributes.map{ |attr| card.send(attr) }
      end
    end
  end

  def self.import(file,deck_id)
    CSV.foreach(file.path, headers: true) do |row|
      card = new
      card.attributes = row.to_hash.slice(*csv_attributes)
      card.rank = 5
      card.deck_id = deck_id
      card.save!
    end
  end
end
