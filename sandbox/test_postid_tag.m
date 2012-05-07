clc

line = '% blha, see `postid: 640` blah and `postid: 640 `';

matches = regexp(line,'`postid:\s?(\d+)\s?`','match')
for i = 1:length(matches)
    m = regexp(matches{i},'`postid:\s?(\d+)\s?`','tokens')

    postid = str2num(char(m{1}));

    post = getPost(postid);
    url = post.get('link')
    
    post_html = sprintf('<a href=%s> Post %i </a>',url,postid);
    line = strrep(line, matches{i}  ,post_html)
end