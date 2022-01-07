class ModsController < ApplicationController
    def index
        mods = Mod.all
        render json: mods
    end
end
