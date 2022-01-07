class HomeController < ApplicationController
    def index
        # My plans
        plans = add_likes_and_forks(@user.plans)
        # My recent activity
        recent_activities = Feed.where(user_id: @user.id).where(created_at: 1.week.ago..Float::INFINITY)
        # My Groups
        groups = @user.groups
        # My Feed
        feed = Feed.joins("INNER JOIN users ON users.id = feeds.user_id").where(users: {id: User.first.followeds.pluck(:id)}).limit(20)
        # Recommendations
        # TODO after hackathon: actually filter and rank and generate recommendations in backend
        recommendations = add_likes_and_forks(Plan.joins(:user).where(users: {primary_degree: @user.primary_degree}).where.not(users: @user))
        json_response({
            plans: plans,
            recent_activities: recent_activities,
            groups: groups,
            feed: feed,
            recommendations: recommendations
        })
    end

    private

    def add_likes_and_forks(plans)
        plans.map do |plan|
            num_of_likes = Like.where(plan_id: plan.id).count
            num_of_forks = Plan.where(forked_plan_source_id: plan.id).count
            plan = plan.attributes
            plan[:num_of_likes] = num_of_likes
            plan[:num_of_forks] = num_of_forks
            plan
        end
    end
end
