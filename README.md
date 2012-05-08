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
