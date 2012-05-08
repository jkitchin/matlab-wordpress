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

In essence, Matlab will publish your file to html, process the m-file to figure out the post title, categories and tags, post-process the html to convert some custom markup I like to use, upload any images in your html to the wordpress server, and change the links in the html to point to them, and then upload the post to the wordpress server.

Example blog
============

You can see an example of this package used at http://matlab.cheme.cmu.edu.

Future work
===========

This package works now, and is pretty good for what I do with it (100 posts at http://matlab.cheme.cmu.edu so far!). It is not difficult to extend right now. You can make up any :directive:`datastring` syntax you want, and define a Matlab function wp_directive(datastring) that will provide the marked up text. One limitation I am currently aware of is:

1. You cannot have nested directives. For example:

   :literal:`:command:`fsolve``

would surely fail to work. The regular expressions used to find those are not smart enough to do nested directives.

It might make sense in a future version to use a syntax similar to [org-mode](http://org-mode.org) like:

   %+WP_TITLE: your title text...
   %+WP_TAGS:  tag1, tag2, ...
   %+WP_CATEGORIES: category1, category2, ...

this is just a variation of what I already do, but it might look cleaner and more recognizable, expecially for the title. these could go anywhere, not just at the top or end.

Finally, I would like to increase the richness of publishing markup, so you can have nested sections, subsections, etc... This will certainly require a totally different approach to publishing than the simple post-processing done here. A proper document node tree will have to be parsed, and then converted to HTML. Each directive will have to be turned into a node then. This would let me write Matlab code like this:

         %* Section 1
         code

         %** subsection 1

         subcode

         %** subsection 2
         next subsection code

         %*** subsubsection
         subsubsection code.

         %* Section 2
         more code

         %* Conclusions
         % text discussing the results

And then it would be rendered in HTML with clickable, hiearchical table of contents. Ideally, there would be no post-processing then, I would just have to upload the html (and figures, files, etc...) to Wordpress. That would be a big project. This kind of thing can be done in [Sphinx](http://sphinx.pocoo.org/), and [org-mode](http://org-mode.org), so there is precedent. But those are big projects!