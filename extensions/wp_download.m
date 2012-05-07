function html = wp_download(datastring)
% upload file in datastring, and return url to the link
% the datastring is a filename,relative to one directory up because we
% are in ../html
fname = fullfile('../', datastring); %assume fname is relative to one directory up
url = newMediaObject(fname);
html = sprintf('<a href=%s> download %s </a>',url,datastring);