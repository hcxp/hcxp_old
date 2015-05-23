class SearchStoriesQuery

  def self.find_for(collection, user, params = {})
    @collection = collection
    @user       = user
    @params     = Marshal::load(Marshal.dump(params))

    apply_domain_filter()

    @collection = @collection.search(@params[:q]) if @params[:q].present?

    @collection
  end

  private

  def self.apply_domain_filter
    # extract domain query since it must be done separately
    domain = nil
    words = @params[:q].to_s.split(' ').reject{|w|
      if m = w.match(/^domain:(.+)$/)
        domain = m[1]
      end
    }.join(' ')

    if domain.present?
      story_ids = Story.select(:id).where("url ~ '//([^/]*\.)?" +
        ActiveRecord::Base.connection.quote_string(domain) + "/'").
        collect(&:id)

      @params[:q].gsub!("domain:#{domain}", '')
      @collection = @collection.where(id: story_ids) if story_ids.any?
    end
  end

end