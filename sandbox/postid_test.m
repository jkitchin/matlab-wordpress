
tline = '%postid = 34 % delete this line to cause a new post'
s = regexp(tline,'^% postid =')
eval(tline(2:end))

% fid = fopen('fakem.m','a+');
% fprintf(fid,'%s\r','%')
% fprintf(fid,'%s\r',s)
% fclose(fid)