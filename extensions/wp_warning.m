function html = wp_warning(datastring)
% returns html for marked up warning as abox with pink background

s = ['<br><FONT style="BACKGROUND-COLOR: LightPink">'...
    'WARNING: %s'...
    '</FONT><br>'];
html = sprintf(s,datastring);
end

