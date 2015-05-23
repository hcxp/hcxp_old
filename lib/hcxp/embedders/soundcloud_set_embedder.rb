require 'nokogiri'

class Hcxp::Embedders::SoundcloudSetEmbedder

  attr_reader :set_id

  def initialize(url)
    @url      = url
    @is_valid = false

    find_set_props()
  end

  def embed_html(args = {})
    width  = args[:width]  || @player_width
    height = args[:height] || @player_height

    # Change to horizontal view
    player = @player.gsub('visual=true', 'visual=false')

    "<iframe src='#{player}' width=#{width}
    height=#{height} frameborder='0' webkitallowfullscreen mozallowfullscreen
    allowfullscreen></iframe>"
  end

  def valid?
    @is_valid == true
  end

  private

  def find_set_props
    body = open(@url).read
    doc  = Nokogiri::HTML(body)

    player  = doc.css("meta[property='twitter:player']")
    @player = player.first.attributes['content'].value if player.any?

    player_width  = doc.css("meta[property='twitter:player:width']")
    @player_width = player_width.first.attributes['content'].value if player_width.any?

    player_height  = doc.css("meta[property='twitter:player:height']")
    @player_height = player_height.first.attributes['content'].value if player_height.any?

    if @player && @player_width && @player_height
      @is_valid = true
    end
  end

end