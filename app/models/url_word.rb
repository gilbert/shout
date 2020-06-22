class UrlWord < ApplicationRecord
  belongs_to :link, optional: true
  validates :word, :uniqueness => true, :presence => true

  def expired?
    self.expires_at < DateTime.now
  end
end
