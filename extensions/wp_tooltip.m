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

html = '<a TITLE="$tooltip_text$" STYLE="COLOR:blue">$$</a>';

% three things to replace:
% 1. the id $tooltip_id$. this will be a UUID for uniqueness
% 2. the tooltip text $tooltip_text$
% 3. the text that has the tooltip on it $$
UUID = char(java.util.UUID.randomUUID);
html = strrep(html,'$tooltip_id$',UUID);
html = strrep(html,'$tooltip_text$', tooltip_text);
html = strrep(html,'$$', text_with_tooltip);
 
end
