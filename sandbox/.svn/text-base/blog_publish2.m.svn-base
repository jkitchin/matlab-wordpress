%% Matlab and xmlrpc with Wordpress
% publish a file to wordpress blog

% [user,password] = wordpress_credentials();
% 
% client = javaObject('org.apache.xmlrpc.client.XmlRpcClient'); 
% config = javaObject('org.apache.xmlrpc.client.XmlRpcClientConfigImpl');
% url = javaObject('java.net.URL', 'http://matlab.cheme.cmu.edu/xmlrpc.php');
% config.setServerURL(url);
% client.setConfig(config);

% We now have a working client and we can execute remote functions.


%% supported methods
% a = client.execute('mt.supportedMethods',{1,user,password})
%{
    'wp.getUsersBlogs'
    'wp.getPage'
    'wp.getPages'
    'wp.newPage'
    'wp.deletePage'
    'wp.editPage'
    'wp.getPageList'
    'wp.getAuthors'
    'wp.getCategories'
    'wp.getTags'
    'wp.newCategory'
    'wp.deleteCategory'
    'wp.suggestCategories'
    'wp.uploadFile'
    'wp.getCommentCount'
    'wp.getPostStatusList'
    'wp.getPageStatusList'
    'wp.getPageTemplates'
    'wp.getOptions'
    'wp.setOptions'
    'wp.getComment'
    'wp.getComments'
    'wp.deleteComment'
    'wp.editComment'
    'wp.newComment'
    'wp.getCommentStatusList'
    'wp.getMediaItem'
    'wp.getMediaLibrary'
    'wp.getPostFormats'
    'blogger.getUsersBlogs'
    'blogger.getUserInfo'
    'blogger.getPost'
    'blogger.getRecentPosts'
    'blogger.getTemplate'
    'blogger.setTemplate'
    'blogger.newPost'
    'blogger.editPost'
    'blogger.deletePost'
    'metaWeblog.newPost'
    'metaWeblog.editPost'
    'metaWeblog.getPost'
    'metaWeblog.getRecentPosts'
    'metaWeblog.getCategories'
    'metaWeblog.newMediaObject'
    'metaWeblog.deletePost'
    'metaWeblog.getTemplate'
    'metaWeblog.setTemplate'
    'metaWeblog.getUsersBlogs'
    'mt.getCategoryList'
    'mt.getRecentPostTitles'
    'mt.getPostCategories'
    'mt.setPostCategories'
    'mt.supportedMethods'
    'mt.supportedTextFilters'
    'mt.getTrackbackPings'
    'mt.publishPost'
    'pingback.ping'
    'pingback.extensions.getPingbacks'
    'demo.sayHello'
    'demo.addTwoNumbers'
%}

% %% categories
% categories = struct;
% a = client.execute('wp.getCategories',{1,user,password});
% for i=1:length(a)
%     category = a(i);
%     category.get('categoryName')
%     category.get('parentId');
%     category.get('categoryId')
% end
% 
% 
% %% new category
% category = java.util.HashMap();
% category.put('name','Category1')
% category.put('slug','category1')
% category.put('parent_id',0)
% %category.put('description','')
% client.execute('wp.newCategory',{1,user,password,category})
% 
% %% get tags
% a = client.execute('wp.getTags', {1,user,password}); 
% 
% tags = {}
% for i=1:length(a)
%     t = a(i);    
%     tag.count = t.get('count');
%     tag.name = t.get('name');
%     tag.tag_id = t.get('tag_id');
%     tag.slug = t.get('slug');
%     tags{i} = tag;
% end
% tags


%% new post
post = java.util.HashMap()
post.put('title','test title')
fid = fopen('html/linefit.html');
s = ''
while 1
    tline = fgets(fid)
    if tline == -1
        break
    end
    s = strcat(s,tline);
end
fclose(fid);
post.put('description',s)
post.put('categories',{'nonlinear algebra'})
post.put('mt_keywords',{'tag1','tag2'})

% a = client.execute('metaWeblog.newPost',{1,user,password,post,true})
% 
% %% upload a file
% file = 'plotting_tutorial_01.png'
% 
% % fid = fopen(file,'rb');
% % bytes = fread(fid);
% % fclose(fid);
% % encoder = sun.misc.BASE64Encoder;
% % encoder = org.apache.commons.codec.binary.Base64;
% % base64string = encoder.encode(bytes);
% 
% fid = fopen(file,'rb');
% bytes = fread(fid,'int8');
% %bytes = javaArray('java.lang.Byte',length(bytes));
% fclose(fid);
% encoder = org.apache.commons.codec.binary.Base64;
% base64string = encoder.encodeBase64(bytes);
% % bytes = javaArray('byte',length(bytes));
% % for i=1:length(base64string)
% %     bytes(i) = java.lang.Byte(base64string(i));
% % end
% 
% 
% data = java.util.HashMap();
% data.put('name',file);
% data.put('type','image/png');
% data.put('bits',encoder.encodeBase64(bytes));
% %data.put('overwrite',java.lang.Boolean('True'));
% %data.put('overwrite',1)
% %a = client.execute('wp.uploadFile',{1,user,password,data})
% a = client.execute('metaWeblog.newMediaObject',{1,user,password,data})
% 
% 
% 
% 
% %{
% wp.uploadFile
% 
% Upload a file.
% Parameters
% 
%     int blog_id
%     string username
%     string password
%     struct data
%         string name
%         string type
%         base64 bits
%         bool overwrite 
% 
% Return Values
% 
%     struct
%         string file
%         string url
%         string type 
% 
%  %}