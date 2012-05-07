function html = wp_tooltip(datastring)
% :tooltip:`<tooltip text> text with tooltip`
% we want to replace the html, which will have been escaped for the <>
[tok]=regexp(datastring,'&lt;(.*)&gt;(.*)','tokens');

if isempty(tok) 
    % this occurs when there are real <>, and not escaped html, e.g. in the
    % hidden commented source code. we just return an unformated datastring
    warning('skipping tooltip for: %s', datastring);
    html = datastring;
    return
end
    
tooltip_text = tok{1}{1};
text_with_tooltip = tok{1}{2};

html = {...
    '<html>'
    '<head>'
    	'<script src="http://cdn.jquerytools.org/1.2.6/full/jquery.tools.min.js"></script>'
'<style>'
'.tooltip {'
	'display:none;'
	'background:transparent url(/tools/img/tooltip/black_arrow.png);'
	'font-size:12px;'
	'height:70px;'
	'width:160px;'
	'padding:25px;'
	'color:#fff;'	
'}'
'#$tooltip_id$ a {'
	'border:0;'
	'cursor:pointer;'
	'margin:0 8px;'
        'color:blue'
'}'
'</style>'
'</head>'
'<div id="$tooltip_id$">'
	'<a title="$tooltip_text$"/>$$</a>'
'</div>'
'<script>'
'$("#demo").tooltip();'
'</script>'
'</html>'
};

 % three things to replace:
% 1. the id $tooltip_id$. this will be a UUID for uniqueness
% 2. the tooltip text $tooltip_text$
% 3. the text that has the tooltip on it $$
UUID = char(java.util.UUID.randomUUID);
html = strrep(html,'$tooltip_id$',UUID);
html = strrep(html,'$tooltip_text$', tooltip_text);
html = strrep(html,'$$', text_with_tooltip);

html = strcat(html{:});
 
end
