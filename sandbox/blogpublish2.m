% here we read in the mfile, modify it and then publish it.
% this doesn't work very well. the publish function doesn't do inline very
% well. 

f = fopen('mfile.m');
s = fread(f,'char=>char')'; %note the transpose operator on string
fclose(f)

%% here we get all the commands and argstrings
[mat tok] = regexp(s,':([a-zA-Z0-9_]*[^:]?):`(.*?)`','match','tokens');

%% process each command
% here we process each command and replace the command string with the
% output from the relevant command
for i=1:length(tok)
    cmd = sprintf('wp_%s',tok{i}{1});
    argstring = tok{i}{2};
    newoutput = feval(cmd,argstring);
    s = strrep(s,mat{i},newoutput);
end

tmpfile = tempname;
tid = fopen('mfile_tmp.m','w');
fwrite(tid,s)
fclose(tid)

edit mfile_tmp.m
%web(sprintf('text://%s',s))