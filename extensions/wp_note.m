function html = wp_note(datastring)
% returns html for marked up warning as abox with pink background

s = ['<br><FONT style="BACKGROUND-COLOR: LightBlue">'...
    'Note: %s'...
    '</FONT><br>'];
html = sprintf(s,datastring);
end

