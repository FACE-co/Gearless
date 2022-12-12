class Review < ApplicationRecord
  belongs_to :rental
  validates :content, :rating, presence: true
  def blank_stars
    5 - rating.to_i
  end

  def message
    time = (Time.now.utc - self.created_at.to_time).round() / 60
    if time < 1
      message = "less than a minute ago"
    elsif time >= 1 && time < 2
      message = "1 minute ago"
    elsif time >= 2 && time < 60
      message = "#{time} minutes ago"
    elsif time >= 60 && time < 120
      message = "1 hour ago"
    elsif time >= 120 && time < 1440
      message = "#{time/60} hours ago"
    elsif time >= 1440 && time < 2880
      message = "1 day ago"
    else time >= 2880
      message = "#{time/1440} days ago"
    end
    return message
  end

end
