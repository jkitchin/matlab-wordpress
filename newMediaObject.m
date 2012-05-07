function url = newMediaObject(filename)
% upload a file to wordpress blog. 
% returns url of the published object

%% now we get credentials and the client
if exist('blogCredentials','file') == 2
    [user,password,server] = blogCredentials();
else
    user = input('Enter your username: ','s');
    password = passwordUI();
    server = input('Enter blog server: ', 's');
end

import net.bican.wordpress.Wordpress;

wp = Wordpress(user,password,server);
file = java.io.File(filename);
filetype = getMimeType(filename);
result = wp.newMediaObject(filetype,file,java.lang.Boolean.FALSE);
url = char(result.getUrl);