class TimelinesController < ApplicationController
    before_action :authenticate_user!

    def index
        user_ids = current_user.followings.pluck(:id)
        @articles = Article.where(user_id: user_ids).order(created_at: :desc)
    end
end