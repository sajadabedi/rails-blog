class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  # def publish!
  #   update!(published_at: Time.zone.now)
  # end

  # def published?
  #   published_at.present?
  # end

  # def draft?
  #   !published?
  # end
end
