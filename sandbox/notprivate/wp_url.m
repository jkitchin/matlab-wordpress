function output = wp_url(argstring)
% to render :url:`text <http://myurl>` 
[tok] = regexp(argstring,'(.*)<(.*)>','tokens');
text = tok{1}{1};
url = tok{1}{2};

s = {'',
    '%%%%', 
    '%% <%s %s>',
    '%% '};

ds = '';
for i=1:length(s)-1
    ds = [ds '\n' s{i}];
end
ds = [ds s{end}];
output = sprintf(ds,url,text)

%%
% <http://www.mathworks.com The MathWorks> 