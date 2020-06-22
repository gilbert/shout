module LinksHelper
  def expire_time(minutes)
    if minutes < 60
      "#{minutes} minutes"
    elsif minutes < 60 * 24
      "#{minutes / 60} hours"
    elsif minutes < 60 * 24 * 28
      "#{minutes / (60 * 24)} days"
    else
      "#{minutes / (60 * 24 * 356)} years"
    end
  end
end
