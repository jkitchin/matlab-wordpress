function post_id = blogpost(mfile, dryrun)
% post the html output of publishing an m-file to matlab.cheme.cmu.edu
% postid = blogpost('my_mfile.m')
%
% you need to create a function called blogCredentials on your Matlab
% path that returns the user and password of the user you will submit
% the post as, and the server:
% function [user, password, server] = blogCredentials()
% user = 'your-user-name';
% password = 'secretpassword';
% server = 'http://matlab.cheme.cmu.edu/xmlrpc.php';
% end function
%
% or you will be prompted for that information.
%
% you can specify categories and tags in your m-file with this markup.
% categories: category1, category2
% tags: tag1, tag2
%
% you can refer to other posts with this syntax: `:postid: 456`. This will
% be converted to a link in the published post (but not in the published
% matlab).
%
% you can add a file to be downloaded with `:download: path-to-file`. The
% path should be relative to your m-file. Note that this function *assumes*
% you are publishing the m-file from the directory where the m-file is.
%
% you can have general markup of :directive:`datastring` as long as
% you make a function called wp_directive that handles datastring.
%
% this function will add a comment to the end of your m-file containing the
% postid that was published. If you repost the m-file later, and the postid
% is still valid, then the existing post will just be updated.
if nargin == 1
    dryrun = false;
else
    dryrun = true;
end

if ~strcmp(mfile(end-1:end),'.m')
    mfile  = [mfile '.m'];
end

%% make sure file has been published
publish(mfile);

% assume this is a new post. this is changed when reading the mfile if an
% old post_id is found
NEWPOST = true;

%% get title, categories and tags from the mfile
text = fileread(mfile);

%% check title
% we take the first line if it starts with %% and has something in it.
title_re = '^%% ([^\n]*)\r';
tokens = regexp(text, title_re, 'tokens');
if length(tokens) == 1
    title = tokens{1}{1};
else
    title = mfile;
end

%% categories
category_re = '% categories:\s*([^\n]*)\r';
[tokens] = regexp(text,category_re, 'tokens');
if length(tokens) > 1
    % there may be zero
    error('Too many categories matches found')
elseif length(tokens) == 1
    categories = regexp(tokens{1},',','split');
    categories = categories{1};
end

%% tags
tags_re = '% tags:\s*([^\n]*)';
[tokens] = regexp(text,tags_re, 'tokens');
if length(tokens) > 1
    error('too many tags lines found')
elseif length(tokens) == 1
    tags = regexp(tokens{1}{1},',','split');
    tags = tags{1};
elseif isempty(tokens)
    tags = [];
end

%% post_id
tokens = regexp(text,'% post_id =\s*(\d*);.*\r','tokens');
if length(tokens) > 1
    error('Too many post_id lines found')
elseif length(tokens) == 1
    post_id = tokens{1}{1};
    validid = validPostId(post_id);
    if validid == true
        NEWPOST = false;
    else
        %stored postid is not valid, it may have been deleted on the blog.
        NEWPOST = true;
    end
end

%% check to make sure each category exists in the blog
% wordpress silently drops categories that don't exist
% add category if it does not exist.
for i = 1:length(categories)
    category = strtrim(categories{i});
    exists = categoryExists(category);
    if ~exists
        newCategory(category);
    end
end

%% process html
% now we get the html and process it looking for images. we need to upload
% each image, get the new url to the image, and replace that in the html
% code. We also look for special markups e.g. `postid: 650` that are
% replaced by urls to those posts.

CWD = pwd;
cd('html')
htmlfile = strrep(mfile,'.m','.html');

htmltext = fileread(htmlfile);

%% handle the Source
% this gets mangled by the substitutions below, so we save it here, replace
% it so nothing is changed, and put it back later
reg = '##### SOURCE BEGIN #####(.*)##### SOURCE END #####';
[match] = regexp(htmltext,reg,'match');
source_code = match{1};

uuid_source_code = char(java.util.UUID.randomUUID);
htmltext = strrep(htmltext, source_code, uuid_source_code);

%% now handle images
reg = ['<img .*?src="'... % up to src="
    '([^"]*)'...     % grab the src filename
    '".*?>'];         % the rest of the link
[tokens] = regexp(htmltext,reg,'tokens');

for i=1:length(tokens)
    %matches{i}
    imgfile = tokens{i}{1};
    % upload new image, and get url
    url = newMediaObject(imgfile);
    % replace the old link with the wordpress url
    htmltext = strrep(htmltext,imgfile,url);
end

%% handle any literal text
% we have to find <pre>text</pre>
% we will find and replace these with a UUID, store that UUID in a
% Containers.map so we can substitute the text back in later.
reg = '<pre>([^<]*)</pre>';
[tokens matches] = regexp(htmltext,reg,'tokens','match');
literal_map = containers.Map();
for i=1:length(matches)
    uuid = char(java.util.UUID.randomUUID);
    literal_map(uuid) = matches{i};

    % now replace matches{i} with uuid
    htmltext = strrep(htmltext, matches{i}, uuid);
end

%% Now handle :cmd:`datastrings`
reg = ':([^:]*):`([^`]*)`';
[tokens matches] = regexp(htmltext,reg,'tokens','match');

for i = 1:length(tokens)
    directive = tokens{i}{1};
    datastring = tokens{i}{2};
    %sprintf('directive = %s', directive)
    %sprintf('datastring = %s', datastring)

    % construct string of command to evaluate wp_directive(datastring)
    % all the wp_cmd functions are in ./extensions
    runcmd = sprintf('wp_%s(''%s'')', directive, datastring);
    html = eval(runcmd);

    % now replace the matched text with the html output
    htmltext = strrep(htmltext, matches{i}, html);
    % now
end

%% put literal text back in
keys = literal_map.keys();
for i=1:length(keys)
    htmltext = strrep(htmltext,keys{i}, literal_map(keys{i}));
end

%% finally, put unmodified source code back in.
htmltext = strrep(htmltext, uuid_source_code, source_code);

tmpfile = tempname;
tid = fopen(tmpfile,'w');
fwrite(tid,htmltext);
fclose(tid);

cd(CWD) % get back to where we started from

%% now we get credentials and the client
if exist('blogCredentials','file') == 2
    [user,password,server] = blogCredentials();
else
    user = input('Enter your username: ','s');
    password = passwordUI();
    server = input('Enter blog server: ', 's');
end

import redstone.xmlrpc.XmlRpcClient;
client = XmlRpcClient(server,0);

%% create the post structure
post = java.util.HashMap();
post.put('title',title);

post.put('description',htmltext);
if ~isempty(categories)
    post.put('categories',categories);
end

if ~isempty(tags)
    post.put('mt_keywords',tags);
end

%% finally the posting action
if dryrun
    web(tmpfile)
    edit(tmpfile)
    pause(5)
else
    if NEWPOST == true
        post_id = client.invoke('metaWeblog.newPost',{1,user,password,post,true});

        p = getPost(post_id);
        fid = fopen(mfile,'a+');
        fprintf(fid,'\r%% post_id = %s; %%delete this line to force new post;\r',char(post_id));
        fprintf(fid,'%% permaLink = %s;\r',char(p.get('permaLink')));
        fclose(fid);
    else
        % edit post
        result = client.invoke('metaWeblog.editPost',{post_id,user,password,post,true});
        if result ~= 1
            disp(result)
        end
    end
end

delete(tmpfile);
close all;