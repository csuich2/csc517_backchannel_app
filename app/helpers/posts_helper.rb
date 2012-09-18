module PostsHelper

  def who_voted_post_link(count, text, id)
    if count > 0
      link_to text, "/posts/who_voted/#{id}", :target => '_blank'
    else
      text
    end
  end

  def who_voted_comment_link(count, text, id)
    if count > 0
      link_to text, "/comments/who_voted/#{id}", :target => '_blank'
    else
      text
    end
  end
end
