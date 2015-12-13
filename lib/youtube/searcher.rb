module Youtube
  class Searcher
    include HTTParty
    base_uri Settings.youtube.api_url
    default_options.update(verify: false)

    def where args
      args[:key] = Youtube.api_key
      args[:part] = 'snippet'
      self.class.get '/search', query: args
    end
  end
end
