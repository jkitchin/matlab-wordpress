function output = command(argstring)
% to render :command:`fsolve` 
% TODO: figure out if I can make the text a link to online documentation
s = {'',
    '%%%%', 
    '%%', 
    '%% <html>', 
    '%% <FONT style="BACKGROUND-COLOR: lightsteelblue" FACE="courier">%s</FONT>',
    '%% </html>',
    '%%',
    '%% '};

ds = '';
for i=1:length(s)-1
    ds = [ds s{i} '\n' ];
end
ds = [ds s{end}];
output = sprintf(ds,argstring)

