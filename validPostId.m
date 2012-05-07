function bool = validPostId(postid)
% find out if the post id is valid. It may not be, if the post has been
% deleted.

%% now we get credentials and the client
if exist('blogCredentials','file') == 2
    [user,password,server] = blogCredentials();
else
    user = input('Enter your username: ','s');
    password = passwordUI();
end

client = redstone.xmlrpc.XmlRpcClient(server,0);

try
    a = client.invoke('metaWeblog.getPost',{postid,user,password});
    bool = true;
catch
    % you get an xmlrpc fault when the postid is not ok.
    bool = false;
end


