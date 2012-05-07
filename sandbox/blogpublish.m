% try to figure out how to modify m-file so it is publishable with the
% markup I am designing. in this approach, I publish the mfile to html, and
% then modify the html. the problem here is not replacing each command
% twice since it shows up in a comment in the html

fclose('all')
fp = publish('mfile')

f = fopen(fp);
s = fread(f,'char=>char')'; % note the transpose operator on string
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



web(sprintf('text://%s',s))