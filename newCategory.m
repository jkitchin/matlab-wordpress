function category_id = newCategory(category,parent_id,description)
% create a new category in matlab blog
%% now we get credentials and the client
if exist('blogCredentials','file') == 2
    [user,password, server] = blogCredentials();
else
    user = input('Enter your username: ','s');
    password = passwordUI();
    server = input('Enter blog server: ', 's');
end

client = redstone.xmlrpc.XmlRpcClient(server,0);

if nargin == 1
    parent_id = 0;
end

%% new category
data = java.util.HashMap();

data.put('name',category);

slug = lower(strrep(category,' ','-'));
data.put('slug',slug);

data.put('parent_id',parent_id);
if nargin == 3
    data.put('description',description);
end

category_id = client.invoke('wp.newCategory',{1,user,password,data});

