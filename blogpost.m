function postid = blogpost(mfile,dryrun)
% post the html output of publishing an m-file to matlab.cheme.cmu.edu
% postid = blogpost('my_mfile.m')
% 
% you need to create a function called wordpress_credentials on your Matlab 
% path that returns the user and password of the user you will submit 
% the post as:
% function [user,password] = wordpress_credentials
% user = 'your-user-name';
% password = 'secretpassword';
% end function
%
% or you will be prompted for that information.
% 
% the title of the post is the name of the m-file.
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
f = publish(mfile);

% assume this is a new post. this is changed when reading the mfile if an
% old post_id is found
NEWPOST = true;

%% get title, categories and tags from the mfile

fid = fopen(mfile,'r+');

% get first line and see if it is ok for title
line = fgetl(fid);
if isempty(line)
    title = mfile;
else
    if ~isempty(regexp(line,'^%%')) && length(line)>3
        title = line(3:end);
    else
        title = mfile;
    end
end

categories = {'uncategorized'};
tags = {};

while 1
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    
    s = regexp(tline,'^% categories:(.*)','tokens');
    if numel(s) > 0
        categories = regexp(s{1},',','split');
        categories = categories{1};
    end
    
    s = regexp(tline,'^% tags:(.*)','tokens');
    if numel(s) > 0
        tags = regexp(s{1},',','split');
        tags = tags{1};
    end
    
    s = regexp(tline,'^% post_id =','once');
    if ~isempty(s)
        eval(tline(2:end)); %sets the post_id variable
        validid = validPostId(post_id);
        if validid
            NEWPOST = false;
        else
            %stored postid is not valid, it may have been deleted on the blog.
            NEWPOST = true;
        end
    end
    
end
fclose(fid);

%% check to make sure each category exists in the blog
% wordpress silently drops categories that don't exist
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

fid = fopen(htmlfile,'r');
tmpfile = tempname;
tid = fopen(tmpfile,'w');

while 1
    line = fgets(fid);
    if line == -1
        break
    end
%% check for image tags, upload images and replace src urls   
   matches = regexp(line,'<img[^>]*>','match');
    for i = 1:length(matches)
        m = regexp(matches{i},'<img.*src="(.*.[png|gif])".*>','tokens');
        imgfile = m{1}{1};
        url = newMediaObject(imgfile);
        line = strrep(line,imgfile,url);
    end
            
    %% check for postid tags. We convert them to links
    [tokens, matches] = regexp(line,':postid:`\s?([0-9]*)\s?`','tokens','match');
    for i = 1:numel(matches)
        postid = str2num(char(tokens{i}));
        matched_text = char(matches{i});
        post = getPost(postid);
        url = post.get('link');
        post_html = sprintf('<a href=%s> Post %i </a>',url,postid);
        line = strrep(line, matched_text ,post_html);
    end
        
    %% now check for download tags. upload file, and replace with links
    [tokens matches] = regexp(line,':download:`\s?([a-zA-Z0-9\s\-_\.]*)\s?`','tokens','match');
    for i = 1:numel(matches)
        fname = strcat(['../', char(tokens{i})]); %assume fname is relative to one directory up
        matched_text = char(matches{i});
        url = newMediaObject(fname);
        post_html = sprintf('<a href=%s> download %s </a>',url,char(tokens{i}));
        line = strrep(line, matched_text, post_html);
    end
    
    %% now check for tooltip tags and replace with html
    [tokens matches] = regexp(line,':tooltip:`(.*)`','tokens','match');
    for i=1:numel(matches)
        datastring = char(tokens{i});
        html = tooltip(datastring);
        line = strrep(line, matches{i}, html);
    end

    [tokens matches] = regexp(line,':command:`(.*)`','tokens','match');
    for i=1:numel(matches)
        datastring = char(tokens{i});
        html = command(datastring);
        line = strrep(line, matches{i}, html);
    end
    
    % write the line to the tmpfile
    fwrite(tid,line);
end

fclose(fid);
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

% read in the file to a string
fid = fopen(tmpfile);
html = fread(fid,inf,'*char')';
fclose(fid);

post.put('description',html);
if ~isempty(categories)
    post.put('categories',categories);
end

if ~isempty(tags)
    post.put('mt_keywords',tags);
end
 
%% finally the posting action
if dryrun
    web(tmpfile)
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