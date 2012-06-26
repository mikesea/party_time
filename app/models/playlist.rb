class Playlist
  include Ripple::Document
  one :event
  many :tracks
end