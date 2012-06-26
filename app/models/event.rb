class Event
  include Ripple::EmbeddedDocument
  property :date, Time
  property :name, String
  property :details, String
  property :location, String
  embedded_in :playlist
end
