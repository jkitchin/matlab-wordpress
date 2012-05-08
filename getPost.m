function post = getPost(postid)
% find out if the post id is valid. It may not be, if the post has been
% deleted.
%
% these are some keys you can "get" from the post.
% [custom_fields, postid, mt_allow_comments, permaLink, post_status, link,
% mt_excerpt, userid, mt_text_more, mt_allow_pings, mt_keywords,
% wp_post_format, sticky, title, date_created_gmt, wp_password,
% description, dateCreated, categories, wp_author_id, wp_slug,
% wp_author_display_name]
%% now we get credentials and the client
if exist('blogCredentials','file') == 2
    [user,password, server] = blogCredentials();
else
    user = input('Enter your username: ','s');
    password = passwordUI();
    server = input('Enter blog server: ', 's');
end

client = redstone.xmlrpc.XmlRpcClient(server,0);

post = client.invoke('metaWeblog.getPost',{postid,user,password});

