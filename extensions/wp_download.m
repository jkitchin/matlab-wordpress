function html = wp_download(datastring)
% upload file in datastring, and return url to the link
% the datastring is a filename,relative to the mfile
url = newMediaObject(datastring);
html = sprintf('<a href=%s> download %s </a>',url,datastring);