# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = User.create([
    {
        name: "Johnny",
        email: "johnyy@u.nus.edu",
        password: "johnny123",
        primary_degree: "Business",
        second_degree: nil,
        second_major: nil,
        first_minor: nil,
        second_minor: nil,
        matriculation_year: 2010
    },
    {
        name: "Jennifer",
        email: "jennifer@u.nus.edu",
        password: "johnny123",
        primary_degree: "Economics",
        second_degree: nil,
        second_major: nil,
        first_minor: nil,
        second_minor: nil,
        matriculation_year: 2011
    },
    {
        name: "Sam",
        email: "sam@u.nus.edu",
        password: "johnny123",
        primary_degree: "Information Systems",
        second_degree: nil,
        second_major: nil,
        first_minor: nil,
        second_minor: nil,
        matriculation_year: 2019
    },
    {
        name: "Edward",
        email: "edward@u.nus.edu",
        primary_degree: "Law",
        password: "johnny123",
        second_degree: nil,
        second_major: nil,
        first_minor: nil,
        second_minor: nil,
        matriculation_year: 2019
    }
])

groups = Group.create([
    {
        name: "CS Planning",
        description: "To plan my CS mods!"
    },
    {
        name: "Business Planning",
        description: "To plan my biz mods!"
    }
])

follows = Follow.create([
    {
        follower_id: 1,
        followed_id: 3
    },
    {
        follower_id: 1,
        followed_id: 4
    },
    {
        follower_id: 2,
        followed_id: 1
    },
    {
        follower_id: 2,
        followed_id: 3
    }
])

members = Member.create([
    {
        group_id: 1,
        user_id: 2,
        is_owner: false
    },
    {
        group_id: 1,
        user_id: 1,
        is_owner: true
    },
    {
        group_id: 2,
        user_id: 3,
        is_owner: false
    },
    {
        group_id: 2,
        user_id: 4,
        is_owner: true
    },
])

plans = Plan.create([
    {
        owner_id: 1,
        forked_plan_source_id: nil,
        is_primary: true,
        start_year: 2010,
        title: "My Business Plan",
        description: nil
    },
    {
        owner_id: 2,
        forked_plan_source_id: nil,
        is_primary: true,
        start_year: 2011,
        title: "My Econs Plan",
        description: "my economics study plan for NUS"
    },
])

semesters = Semester.create([
    {
        plan_id: 1,
        year: 2010,
        semester_no: 1
    },
    {
        plan_id: 1,
        year: 2010,
        semester_no: 2
    },
    {
        plan_id: 2,
        year: 2011,
        semester_no: 1
    },
    {
        plan_id: 2,
        year: 2011,
        semester_no: 2
    },
])

mods = Mod.create([
    {
        semester_id: 1,
        module_code: "CS1101S",
        module_title: "Programming Methodology I",
        additional_desc: nil,
        order: 1,
    },
    {
        semester_id: 1,
        module_code: "CS1231S",
        module_title: "Discrete Structures",
        additional_desc: nil,
        order: 2,
    },
    {
        semester_id: 1,
        module_code: "MA1521",
        module_title: "Calculus for Computing",
        additional_desc: nil,
        order: 3,
    },
    {
        semester_id: 2,
        module_code: "CS1101S",
        module_title: "Programming Methodology I",
        additional_desc: nil,
        order: 1,
    },
    {
        semester_id: 2,
        module_code: "PC1101",
        module_title: "Frontiers of Physics",
        additional_desc: nil,
        order: 1,
    },
    {
        semester_id: 2,
        module_code: "PC1201",
        module_title: "Fundamentals of Physics",
        additional_desc: nil,
        order: 2,
    },
])

likes = Like.create([
    {
        plan_id: 1,
        user_id: 2
    },
    {
        plan_id: 1,
        user_id: 1
    },
    {
        plan_id: 2,
        user_id: 3
    },
])

feeds =  Feed.create([
    {
        user_id: 1,
        activity_type: "created a new plan",
        plan_id: 1,
        second_plan_id: nil,
        group_id: nil,
        raw_data: nil
    },
    {
        user_id: 2,
        activity_type: "created a new plan",
        plan_id: 2,
        second_plan_id: nil,
        group_id: nil,
        raw_data: nil
    },
])

