module PostsHelper
  def markitup(selector='textarea', type='textile')
    <<-HERE
    <script type="text/javascript" src="/markitup/jquery.markitup.js"></script>
    <script type="text/javascript" src="/markitup/sets/#{type}/set.js"></script>
    <link rel="stylesheet" type="text/css" href="/markitup/skins/simple/style.css" />
    <link rel="stylesheet" type="text/css" href="/markitup/sets/#{type}/style.css" />
    <script type="text/javascript" >
       $(document).ready(function() {
          $("#{selector}").markItUp(mySettings);
       });
    </script>
    HERE
  end
  
  def author_of(post)
    unless post.visitor.blank?
      post.visitor
    else
       link_to post.user, user_path(post.user)
    end
  end
end
