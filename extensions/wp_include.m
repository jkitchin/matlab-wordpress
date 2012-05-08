function html = wp_include(datastring)
% :include:`htmlfile`
% this is to include an external html file into a post
fid = fopen(datastring,'r+');

html = fread(fid);

fclose(fid)'

end