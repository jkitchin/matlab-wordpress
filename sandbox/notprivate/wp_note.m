function output = note(argstring)
% :note:`text to put in note`
% should work for multiline comments.

s = {'',
    '%%%%', 
    '%%', 
    '%% <html>', 
    '%% <P><FONT style="BACKGROUND-COLOR: lightsteelblue" FACE="courier">',
    '%% Note: %s</FONT></P>',
    '%% </html>',
    '%% '};

ds = '';
for i=1:length(s)-1
    ds = [ds s{i} '\n' ];
end
ds = [ds s{end}]
arg = regexprep(argstring, '% |\n|\r','');
output = sprintf(ds,arg)
