matlab-wordpress
================

Matlab module for publishing m-files to a Wordpress blog

John Kitchin <jkitchin@cmu.edu>
Added to Github on May 7, 2012

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

INSTALLATION
============

Get the code with one of these options.

1. with git:

   git clone git@github.com:johnkitchin/matlab-wordpress.git

2. as a zip file:

   wget -O wordpress.zip https://github.com/johnkitchin/matlab-wordpress/zipball/master
   unzip wordpress.zip

Now, make sure to add the directory formed in 1 or 2 to your Matlab path.

You will need some code like this in your startup.m file to put the java files on your javaclasspath:

    javaclasspath({fullfile(MATLABROOT,'internal/matlab-wordpress/jwordpress-0.4.jar'),...
        fullfile(MATLABROOT,'internal/matlab-wordpress/xmlrpc-client-1.1.1.jar')});

Usage
=====

You prepare your blogpost in the editor of your choice as a valid m-file. I frequently publish to html to preview how it will look. When you are ready to post, at the matlab command prompt, type:

    blogpost mfile.m

You will be prompted for the username, password and server to post to. To avoid this, create an m-file on your Matlab path called blogCredentials.m with these contents:

    function [user,password,server] = blogCredentials
    % returns username and password for matlab blog

    user = 'your-blog-login';
    password = 'your-blog-password';
    server = 'http://your-blog/xmlrpc.php';

In your Wordpress blog, you will have to enable XML-RPC (Enable the WordPress, Movable Type, MetaWeblog and Blogger XML-RPC publishing protocols). This is under Settings -> Writing -> Remote Publishing.

Example blog
============

You can see an example of this package used at http://matlab.cheme.cmu.edu.
