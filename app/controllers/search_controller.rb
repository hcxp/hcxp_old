class SearchController < ApplicationController

  before_action :set_search_whats, only: [:index]
  before_action :set_search_orders, only: [:index]

  def index
    @title = "Search"
    @cur_url = "/search"
    @what  = params[:what]  || 'stories'
    @order = params[:order] || 'relevance'
    @results = []

    return unless params[:q].present?

    if @what == 'comments'
      @results = SearchCommentsQuery.find_for(Comment.all, @user, params)
    else
      @results = SearchStoriesQuery.find_for(Story.all, @user, params)
    end

    if params[:order].present?
      case @order
      when 'newest'
        @results = @results.order(:created_at)
      when 'points'
        @results = @results.order('upvotes - downvotes DESC')
      end
    end

    @results = @results.page(params[:page])
  end

  private

  def set_search_whats
    @search_whats = [
      ['Stories', 'stories'],
      # ['Comments', 'comments']
    ]
  end

  def set_search_orders
    @search_orders = [['Relevance', 'relevance'], ['Newest', 'newest'], ['Points', 'points']]
  end
end
