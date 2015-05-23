module StoriesHelper
  def show_guidelines?
    if !@user
      return true
    end

    if @user.stories_submitted_count <= 5
      return true
    end

    if Moderation.joins(:story).
    where("stories.user_id = ? AND moderations.created_at > ?", @user.id,
    5.days.ago).count > 0
      return true
    end

    false
  end

  def show_story_embed(story, args = {})
    embedder = Hcxp::Embedder.embed_html_for(story.url, args)

    if embedder.present?
      content_tag :div, embedder.html_safe, class: 'story-embed'
    end
  end
end
