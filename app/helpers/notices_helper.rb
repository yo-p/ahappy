module NoticesHelper
    def notice_form(notice)
        visitor = link_to notice.visitor.name, notice.visitor
        @comment = nil
        your_tweet = link_to 'あなたの投稿', notice.tweet

        case notice.action
        when 'favorite' then
            "#{visitor}が#{your_tweet}をお気に入りしました！"
        when 'comment' then
            @comment = Comment.find_by(id: notice.comment_id)
            "#{visitor}が#{your_tweet}にコメントしました!"
        end
    end

    def unchecked_notices
        @notices = current_user.passive_notices.where(checked: false)
    end
end
