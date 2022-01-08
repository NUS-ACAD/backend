class Feed < ApplicationRecord
    ACTIVITY_TYPES = {
        created_plan: "created_plan",
        forked_plan: "forked_plan",
        updated_plan: "updated_plan",
        deleted_plan: "deleted_plan",
        changed_group: "changed_group",
        deleted_group: "deleted_group",
        changed_primary_plan: "changed_primary_plan",
        created_group: "created_group"
    }

    belongs_to :user
end
