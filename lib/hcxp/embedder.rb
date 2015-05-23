class Hcxp::Embedder

  def self.embed_html_for(url, args = {})
    @url      = url
    @embedder = determine_embedder()

    if @embedder.present?
      class_name = "Hcxp::Embedders::#{@embedder.to_s.classify}Embedder".constantize
      embedder   = class_name.send(:new, @url)

      if embedder.valid?
        embedder.embed_html(args)
      end
    end
  end

  private

  def self.determine_embedder
    if !@url[/.+hate5six\.com.+album\=\d+/].nil?
      :hate5six_album

    elsif !@url[/https?\:\/\/soundcloud\.com.+\/sets\/.+/].nil?
      :soundcloud_sets

    elsif !@url[/https?\:\/\/(www.)?youtube\.com\/.+/].nil?
      :youtube

    elsif !@url[/https?\:\/\/(.+).bandcamp\.com\/.+/].nil?
      :bandcamp
    end
  end

end