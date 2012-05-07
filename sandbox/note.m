function output = note(datastring)

ds = strrep(datastring, '% ',''); %remove comments

output = sprintf('<P bgcolor= "yellow" border=0><FONT style="BACKGROUND-COLOR: yellow">%s</FONT></P>',ds);
