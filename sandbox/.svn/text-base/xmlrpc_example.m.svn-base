%% Matlab and xmlrpc with Wordpress
% http://codex.wordpress.org/XML-RPC_wp
%{
metaWeblog.newPost (blogid, username, password, struct, publish) returns string

metaWeblog.editPost (postid, username, password, struct, publish) returns true

metaWeblog.getPost (postid, username, password) returns struct

%}

client = javaObject('org.apache.xmlrpc.client.XmlRpcClient'); 
config = javaObject('org.apache.xmlrpc.client.XmlRpcClientConfigImpl');
url = javaObject('java.net.URL', 'http://matlab.cheme.cmu.edu/xmlrpc.php');
config.setServerURL(url);
client.setConfig(config);

% We now have a working client and we can execute remote functions.

[user,password] = wordpress_credentials();

%% supported methods
a = client.execute('mt.supportedMethods',{1,user,password})
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

blogs = client.execute('wp.getUsersBlogs', {user,password})

%% new category
% client.execute('wp.newCategory',{1,user,password,{'newCat','newcat',0,'test'}})

%% get information
a = client.execute('wp.getTags', {1,user,password}); 
for i=1:length(a)
    tag = a(i);    
    tag.get('count')
    tag.get('name')
    tag.get('tag_id')
end

%% categories
a = client.execute('wp.getCategories',{1,user,password});
for i=1:length(a)
    category = a(i);
    category.get('categoryName')
    category.get('parentId');
    category.get('categoryId')
end

disp('mt.getPostCategories')
a = client.execute('mt.getPostCategories',{1,user,password});
for i=1:length(a)
    category = a(i);
    category.get('categoryName')
    category.get('parentId');
    category.get('categoryId')
end


%% get pages
a = client.execute('wp.getPages',{1,user,password});
for i = 1:length(a)
    page = a(i);
    page.get('page_id')
    page.get('title')
end

%% get a post
a = client.execute('metaWeblog.getPost',{1, user, password})
a.get('postid')
a.get('categories')

%% new post
post = struct('title','new title','description','my desc','mt_keywords','tag1,tag2');
a = client.execute('blogger.newPost',{1,user,password,post,0})


%{
wp.newPage

Create a new page. Similar to metaWeblog.newPost.
Parameters

    int blog_id
    string username
    string password
    struct content
        string wp_slug
        string wp_password
        int wp_page_parent_id
        int wp_page_order
        int wp_author_id
        string title
        string description (content of post)
        string mt_excerpt
        string mt_text_more
        int mt_allow_comments (0 = closed, 1 = open)
        int mt_allow_pings (0 = closed, 1 = open)
        datetime dateCreated
        array custom_fields
            struct
            Same struct data as custom_fields in wp.getPage 

    bool publish 

Return Values

    int page_id 

wp.uploadFile

Upload a file.
Parameters

    int blog_id
    string username
    string password
    struct data
        string name
        string type
        base64 bits
        bool overwrite 

Return Values

    struct
        string file
        string url
        string type 

wp.newCategory

Create a new category.
Parameters

    int blog_id
    string username
    string password
    struct
        string name
        string slug
        int parent_id
        string description 

Return Values

    int category_id 

wp.editPage

Make changes to a blog page.
Parameters

    int blog_id
    int page_id
    string username
    string password
    struct content
        Same struct data as newPage 
    bool publish 

Return Values

    bool true 
 %}