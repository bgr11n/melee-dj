module Youtube
  class Video
    include HTTParty
    base_uri Settings.youtube.api_url
    default_options.update(verify: false)

    def initialize uri
      @res = self.class.get '/videos', query: default_args.merge({id: uri})
    end

    def duration
      to_sec(@res['items'][0]['contentDetails']['duration'])
    end

  private

    def default_args
      {
        key: Youtube.api_key,
        part: 'contentDetails'
      }
    end

    def to_sec duration
      reg = /^PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?$/
      hours, minutes, seconds, total = [0, 0, 0, 0]

      match = duration.scan(reg).flatten

      hours = match[0].to_i if match[0]
      minutes = match[1].to_i if match[1]
      seconds = match[2].to_i if match[2]

      total = hours * 3600  + minutes * 60 + seconds
      total
    end
  end
end
