function output = wp_warning(argstring)
% :warning:`text to put in warning`
% should work for multiline warning.

s = {'',
    '%%%%', 
    '%%', 
    '%% <html>', 
    '%% <P><FONT style="BACKGROUND-COLOR: hotpink">',
    '%% Warning: %s</FONT></P>',
    '%% </html>',
    '%% '};

ds = '';
for i=1:length(s)-1
    ds = [ds  s{i} '\n'];
end
ds = [ds s{end}];
output = sprintf(ds,strrep(argstring, '% ',''))
