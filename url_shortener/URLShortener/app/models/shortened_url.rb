class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true
  def self.random_code
    rand_url = SecureRandom.urlsafe_base64

    until !ShortenedUrl.exists?(short_url: rand_url)
      rand_url = SecureRandom.urlsafe_base64
    end

    rand_url
  end

  def self.generate_url(user, long_url)
    rando = self.random_code
    ShortenedUrl.create!(long_url:long_url, short_url:rando, user_id:user.id)
  end

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
end
