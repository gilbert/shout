class Link < ApplicationRecord
  has_many :url_words
  validate :check_url

  def check_url
    if url.blank? || !Link.valid_url?(url)
      errors.add(:url, "is not a valid URL")
    end
  end

  def self.valid_url?(value)
    uri = URI.parse(value)
    uri && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end
