class Playlist
  include Ripple::Document

  # property :from,    String, :presence => true
  # property :to,      String, :presence => true
  property :event_date,    Time
  many :tracks
end