module Youtube
  class Video
    include HTTParty
    base_uri Settings.youtube.api_url
    default_options.update(verify: false)

    def initialize uri
      @res = self.class.get '/videos', query: default_args.merge({id: uri})
    end

    def duration
      @res['items'][0]['contentDetails']['duration']
    end

  private

    def default_args
      {
        key: Youtube.api_key,
        part: 'contentDetails'
      }
    end
  end
end
