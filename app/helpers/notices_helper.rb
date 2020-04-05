module NoticesHelper
    def notice_form(notice)
        @visitor = notice.visitor
        @comment = nil
        @visitor_comment = notice.comment_id
        case notice.action
        when 'favorite'
            tag.a(notice.visitor.name, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: tweet_path(notification.tweet_id)) + 'にいいねしました'
        when 'comment'
            @comment = Comment.find_by(id: @visitor_comment)
            @comment_content = @comment.content
            @tweet_title = @comment.tweet.title
            tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@tweet_title}", href: tweet_path(notification.tweet_id)) + 'にコメントしました'
        end
    end
end
