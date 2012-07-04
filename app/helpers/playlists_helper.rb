module PlaylistsHelper
	def playlist_id_tag
    tag('meta', name: 'playlist_id', content: @playlist.key)
  end

  def playback_token_tag
    tag('meta', name: 'playback_token', content: RDIO.getPlaybackToken(domain: "party.dev"))
  end
end
