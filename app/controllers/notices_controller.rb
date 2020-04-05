class NoticesController < ApplicationController

    def index
        @notices = current_user.passive_notices
        @notices.where(checked: false).each do |notice|
            notice.update_attributes(checked: true)
        end
    end

    def destroy
        @notices = current_user.passive_notices.destroy.all
        redirect_to notices_path
    end
end
