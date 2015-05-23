class ScrapStoryThumbWorker
  include Sidekiq::Worker

  def perform(story_id)
    @story = Story.find(story_id)

    if @story.url.present?
      thumb_url = Hcxp::ThumbnailScrapper.new.scrap(@story.url)
    end

    if thumb_url.present?
      @story.update_attribute(:remote_thumb_url, thumb_url)
    end

  rescue => e
    Rails.logger.warn "Thumb scrapping for story ##{story_id} failed. Reason: #{e.message}"
  end
end