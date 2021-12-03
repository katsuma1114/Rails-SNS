class ProfilesController < ApplicationController
    def show
    end

    def edit
    end

    private
    def profile_params
        params.require(:profile).permit(:avatar)
    end
end