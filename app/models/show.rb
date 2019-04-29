class Show
  include ActiveModel::Model

  attr_accessor :title, :link, :author, :subtitle, :explicit, :category, :image_url
  attr_accessor :episodes

  def self.all
    Rails.cache.fetch("all-shows", expires_in: 10.minutes) do
      Dir['./test/fixtures/*.yml'].map do |file|
        from_yml(File.basename(file, '.yml'))
      end
    end
  end

  def self.find_by_id(id)
    all.detect {|show| show.id == id }
  end

  def self.find_by(title)
    all.detect {|show| show.title == title }
  end

  def self.from_yml(filename)
    from_feed(YAML.load(File.read("./test/fixtures/#{filename}.yml")))
  end

  def self.from_feed(attrs)
    atts = {
      explicit: attrs["explicit"]&.downcase == "yes",
      link: [attrs["link"]].flatten.last,
      image_url: [attrs["image"]].flatten.last["href"]
    }.merge(
      attrs.slice(*%w(
        title author subtitle category
      ))
    )
    new(atts).tap do |show|
      show.episodes = attrs["item"].map do |episode|
        Episode.from_feed(episode).tap {|ep| ep.show = show }
      end
    end
  end

  def id
    @id ||= Base64.urlsafe_encode64(title)
  end

  def find_episode_by_id(episode_id)
    episodes.detect {|ep| ep.id == episode_id }
  end

  def find_episode_by_title(title)
    episodes.detect {|ep| ep.title == title }
  end
end
