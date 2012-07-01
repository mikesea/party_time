class SearchTrack extends Spine.Model
  @configure 'SearchTrack', 'artist_name', 'title', 'rdio_id', 'album_title'

  addToPlaylist: ->
    $.ajax
      url: Track.url()
      data: {
        track: {
          title: this.title,
          artist_name: this.artist_name,
          album_title: this.album_title,
          rdio_id: this.id
        } 
      }
      type: "post"
      success: (track) =>
        Track.create
          id: track.id
          artist_name: track.artist_name,
          title: track.title,
          album_title: track.album_title
          { ajax: false }
      error: (data) =>
        console.log data

window.SearchTrack = SearchTrack