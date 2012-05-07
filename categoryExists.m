function bool = categoryExists(category)

existing_categories = getCategories;

for i = 1:length(existing_categories)
    if strmatch(lower(category),lower(existing_categories{i}))
        bool = true;
        return
    end
end

%no match found
bool = false;