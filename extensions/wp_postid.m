function html = wp_postid(datastring)
% turn :postid:`number` to a clickable link
postid = str2num(datastring);
post = getPost(postid);
url = post.get('link');
html = sprintf('<a href=%s> Post %i </a>',url,postid);
end
