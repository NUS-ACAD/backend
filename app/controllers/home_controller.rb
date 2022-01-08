class HomeController < ApplicationController
    def index
        # My plans
        plans = add_likes_and_forks(@user.plans)
        # My recent activity
        recent_activities = add_group_size(Feed.where(user_id: @user.id).where(created_at: 1.week.ago..Float::INFINITY))
        # My Groups
        groups = @user.groups
        # My Feed
        feed = add_group_size(Feed.joins(:user).where(users: {id: @user.followeds.pluck(:id)}).limit(20))
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

    def add_group_size(feed)
        feed.map do |f|
            f = f.attributes.transform_keys(&:to_sym)
            f[:group_size] = nil
            if f[:group_id] && Group.find_by(id: f[:group_id])
                f[:group_size] = Group.find(f[:group_id]).members.length
            end
            f
        end
    end
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
