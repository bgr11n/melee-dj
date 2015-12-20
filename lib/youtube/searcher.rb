require 'youtube/serializers/video_serializer'

module Youtube
  class Searcher
    include HTTParty
    include ::Youtube::Serializer::VideoSerializer
    base_uri Settings.youtube.api_url
    default_options.update(verify: false)

    def where args
      res = self.class.get '/search', query: default_args.merge(args)
      res['items'].map { |i| serialize_video(i) }
    end

  private

    def default_args
      {
        key: Youtube.api_key,
        part: 'snippet'
      }
    end
  end
end
