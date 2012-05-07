%% Matlab and xmlrpc with Wordpress
% publish a file to wordpress blog
function result = newMediaObject(filename)
% upload a png file to wordpress blog

% check for png extension
[path, name, ext] = fileparts(filename);
if ~strcmp(ext,'.png')
    error('you can only upload a png file!')
end

[user,password] = wordpress_credentials();

javaclasspath({'C:\Users\jkitchin\My Dropbox\MATLAB\CMU_matlab\matlab-svn\wordpress/jwordpress-0.4.jar'})
import net.bican.wordpress.Wordpress;

wp = Wordpress(user,password,'http://matlab.cheme.cmu.edu/xmlrpc.php')
file = java.io.File(filename);
mimeTypemap = MimetypesFileTypeMap()
mimeType = mimeTypemap.getContentType(file);

result = wp.newMediaObject('image/png',file,java.lang.Boolean.FALSE);