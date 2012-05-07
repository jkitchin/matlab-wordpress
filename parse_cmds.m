f = fopen('mfile.m');

s = fread(f,'char=>char')'

[mat tok] = regexp(s,':(.*?):`(.*?)`','match','tokens');

for i=1:length(tok)
    cmd = sprintf('wp_%s',tok{i}{1});
    argstring = tok{i}{2};
    feval(cmd,argstring)
end