function output = postid(argstring)
id = str2num(argstring);

% find out if the post id is valid. It may not be, if the post has been
% deleted.

%% now we get credentials and the client
if exist('blogCredentials','file') == 2
    [user,password] = blogCredentials();
else
    user = input('Enter your username: ','s');
    password = passwordUI();
end

client = redstone.xmlrpc.XmlRpcClient('http://matlab.cheme.cmu.edu/xmlrpc.php',0);

try
    a = client.invoke('metaWeblog.getPost',{id,user,password});
    bool = true;
catch
    % you get an xmlrpc fault when the postid is not ok.
    bool = false;
end

if bool
    s = {'',
        '%% <%s %s>',
        '%% '};

    ds = '';
    for i=1:length(s)-1
        ds = [ds s{i} '\n'];
    end
    ds = [ds s{end}];
    
    posturl = sprintf('http://matlab.cheme.cmu.edu/?p=%i',id);
    text = sprintf('post %i',id);
    output = sprintf(ds,posturl,text);
else
    error('invalid post');
end

%%
% <http://www.mathworks.com The MathWorks> 