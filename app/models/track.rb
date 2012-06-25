class Track
  include Ripple::EmbeddedDocument
  property :artist_name, String
  property :title, String
  property :rdio_id, String
  embedded_in :playlist
end
