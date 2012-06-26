module PlaylistsHelper
	def playlist_id_tag
    tag('meta', name: 'playlist_id', content: @playlist.key)
  end
end
