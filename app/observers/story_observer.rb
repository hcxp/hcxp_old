class StoryObserver < ActiveRecord::Observer
  def after_create(story)
    story.logger.info('New story added!')

    # Scrap thumbnail
    ScrapStoryThumbWorker.perform_async(story.id)
  end

  def after_update(story)
    story.logger.info("Story with an id of #{story.id} has been updated")

    # Scrap thumbnail
    ScrapStoryThumbWorker.perform_async(story.id) if story.url_changed?
  end

  def after_destroy(story)
    story.logger.warn("Story with an id of #{story.id} was destroyed!")
  end
end