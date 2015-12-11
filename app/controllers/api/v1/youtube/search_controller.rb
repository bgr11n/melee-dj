module Api::V1::Youtube
  class SearchController < Api::ApiController
    def index
      videos = Yt::Collections::Videos.new
      res = videos.where(q: params[:q], order: 'relevance', 'maxResults' => 10).map(&:title).size
      render json: res
    end

  private

    def serializer
      Proc.new do |video|
        {
          uri: video.id,
          title: video.title,
          description: video.description,
          thumbnail_url: video.thumbnail_url,
          duration: video.duration
        }
      end
    end
  end
end
