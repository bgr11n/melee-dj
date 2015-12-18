require 'youtube'

class Track
  include Mongoid::Document
  include Mongoid::Timestamps

  field :uri,              type: String
  field :title,            type: String
  field :thumbnail,        type: String
  field :duration,         type: Integer

  def update_info data
    video = Youtube::Video.new data[:uri]
    update title: data[:title],
           thumbnail: data[:thumbnail],
           duration: video.duration
  end
end
