function output = command(argstring)
% :download:`filename` 
% filename should is relative to the html file.

fname = strcat(['../', strtrim(argstring)]);
url = newMediaObject(fname);

s = {'',
    '%%%%', 
    '%%', 
    '%% <html>', 
    '%% <a href="%s">(download %s)',
    '%% </a>',
    '%% </html>',
    '%% };

ds = '';
for i=1:length(s)-1
    ds = [ds '\n' s{i}];
end
ds = [ds s{end}];
output = sprintf(ds,url,argstring)

    
