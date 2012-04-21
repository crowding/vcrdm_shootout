function m = link_psychtoolbox()

x = which('-all', 'screen');

for f = x(:)'
    status = system(sprintf('ln -sf ''%s'' +Psychtoolbox/', f{1}));
    if (status ~= 0)
        error('fail:fail', 'failed linking %s', f{1})
    end
end

end
