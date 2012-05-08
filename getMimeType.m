function mimetype = getMimeType(filename)
% returns mimetype based on file extension
%
% I found it easier to just define these myself than rely on any
% external library.
[pathstr, name, ext] = fileparts(filename);

c = containers.Map();
c('.png') = 'image/png';
c('.gif') = 'image/gif';
c('.jpeg')= 'image/jpeg';
c('.jpg') ='image/jpeg';
c('.tif') = 'image/tiff';
c('.tiff') ='image/tiff';
c('.bmp') = 'image/x-ms-bmp';

c('.mat') = 'application/octet-stream'; % matlab file
c('.m') = 'text/plain';
c('.dat') = 'text/plain';
c('.txt') = 'text/plain';

c('.xls') = 'application/excel';
c('.xls') = 'application/vnd.ms-excel';
c('.doc') = 'application/word';
c('.docx') = 'application/word';
mimetype = c(ext);