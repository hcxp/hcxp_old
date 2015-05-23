class Hcxp::Embedders::Hate5sixAlbumEmbedder

  attr_reader :video_id

  def initialize(url)
    @url      = url
    @is_valid = false
    @video_id = find_video_id()
  end

  def embed_html(args = {})
    width  = args[:width]  || '100%'
    height = args[:height] || 500

    "<iframe src='https://player.vimeo.com/video/#{@video_id}' width=#{width}
    height=#{height} frameborder='0' webkitallowfullscreen mozallowfullscreen
    allowfullscreen></iframe>"
  end

  def valid?
    @is_valid == true
  end

  private

  def find_video_id
    body = open(@url).read
    id = body.match(/embedCode\((\d+)\)/)[1]

    if id.present?
      @is_valid = true
      return id
    end
  end

end