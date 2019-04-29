class Episode
  include ActiveModel::Model

  attr_accessor :title, :subtitle, :published_at, :url, :guid,
    :description, :explicit, :duration, :image_url, :audio_url
  attr_accessor :show

  def self.from_feed(attrs)
    atts = {
      explicit: attrs["explicit"]&.downcase == "yes",
      image_url: attrs.dig("image", "href"),
      audio_url: attrs["enclosure"]["url"],
      url: attrs["link"],
      published_at: Date.parse(attrs["pubDate"]),
      title: [attrs["title"]].flatten.first
    }.merge(attrs.slice(*%w[subtitle guid description duration]))

    new(atts)
  end

  def id
    @id ||= Base64.urlsafe_encode64(title)
  end
end
