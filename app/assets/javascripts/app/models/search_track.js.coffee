class SearchTrack extends Spine.Model
  @configure 'SearchTrack', 'artist_name', 'title', 'rdio_id', 'album_title', 'album_art'

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
        $(".search-alert").empty()
        $(".search-alert").append "<p>Success! Added to your playlist</p>"
        Track.create
          id: track.id
          artist_name: track.artist_name,
          title: track.title,
          album_title: track.album_title
          { ajax: false }
      error: (data) =>
        $(".search-alert").empty()
        $(".search-alert").prepend "<p style='color:red;'>Looks like that track is already in your playlist!</p>"

window.SearchTrack = SearchTrack