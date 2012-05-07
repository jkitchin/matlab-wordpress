function html = wp_command(datastring)
% returns html for marked up command
% datastring should be just the command name
%
% makes :command:`fsolve` into a clickable link to Matlab
% documentation (via search) and changes the background color.

s = ['<FONT style="BACKGROUND-COLOR: LightGray" FACE="courier">'...
    '<a href="http://www.mathworks.com/searchresults/?c[]=entiresite&q=%s">'...
    '%s'...
    '</a></FONT> command'];
html = sprintf(s,datastring,datastring);
end

