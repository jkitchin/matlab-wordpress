function categories = getCategories

%% now we get credentials and the client
if exist('blogCredentials','file') == 2
    [user, password, server] = blogCredentials();
else
    user = input('Enter your username: ','s');
    password = passwordUI();
    server = input('Enter blog server: ', 's');
end

client = redstone.xmlrpc.XmlRpcClient(server,0);

%% categories
categories = {};
a = client.invoke('wp.getCategories',{1,user,password});
a = a.toArray();
for i=1:length(a)
    category = a(i);
    name = category.get('categoryName');
    category.get('parentId');
    category.get('categoryId');
    categories = cat(1,categories,char(name));
end

