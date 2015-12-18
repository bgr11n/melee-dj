module Youtube::VideoSerializer
  def serialize_video data
    {
      uri: data['id']['videoId'],
      title: data['snippet']['title'],
      thumbnail: data['snippet']['thumbnails']['default']['url']
    }
  end
end
