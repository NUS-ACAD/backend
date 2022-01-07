class SemestersController < ApplicationController
    def index
        semesters = Semester.all
        render json: semesters
    end
end
