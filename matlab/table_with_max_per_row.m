function table_with_max_per_row(data, row_names, col_names, row_max_min, column_groups)

ncols = size(data,2);
nrows = size(data,1);

if ~exist('column_groups','var')
    % The optimum values are computed within these sets of columns
    % (one id per group, e.g. [1 1 2 2 2 2] means two columns in one group, four in another)
    column_groups = ones(1,ncols);
end
if ~exist('row_max_min','var')
    % Define if each measure is good max or min
    row_max_min = ones(1,nrows);
end

disp('% ------ Matlab-generated LaTeX code ------')


% Compute padding for each column
padding = 10*ones(1,ncols);
if exist('col_names','var')
    for ii=1:ncols
        padding(ii) = max(padding(ii), length(col_names{ii})+1);
    end
end

% Compute padding for first column
padding_first = 0;
ampersan_first = '';
if exist('row_names','var')
    ampersan_first = '&';
    for ii=1:nrows
        padding_first = max(padding_first, length(row_names{ii})+1);
    end
else
    row_names = cell(1,nrows);
    for ii=1:nrows
        row_names{ii} = '';
    end 
end

% Show header
if exist('col_names','var')
    fprintf('%s%s ', repmat(' ',1,padding_first), ampersan_first);
    for ii=1:ncols
        if ii==ncols
            fprintf('%s%s \\\\\n', col_names{ii}, repmat(' ',1,padding(ii)-length(col_names{ii})));
        else
            fprintf('%s%s & ', col_names{ii}, repmat(' ',1,padding(ii)-length(col_names{ii})));
        end
    end
end

% Show the table
for ii=1:nrows
    % Display row name
    fprintf('%s%s%s', row_names{ii}, repmat(' ',1,padding_first-length(row_names{ii})), ampersan_first);

    % Get the maximum on each of the groups
    n_groups = length(unique(column_groups));
    max_ids = zeros(1,n_groups);
    for jj=1:n_groups
        if row_max_min(ii)
            tmp = data(ii,:); tmp(column_groups~=jj) = 0;
            [~, max_ids(jj)] = max(tmp);
        end
    end

    for jj=1:ncols
        if data(ii,jj)<0, sp = ' '; else sp = '\ '; end
        if jj==1, amp = ''; else amp = ' &'; end
        if ismember(jj,max_ids)
            fprintf('%s \\bf%s%0.3f%s', amp, sp, data(ii,jj), repmat(' ',1,padding(jj)-10));
        else
            fprintf('%s    %s%0.3f%s', amp, sp, data(ii,jj), repmat(' ',1,padding(jj)-10));
        end
    end
    fprintf(' \\\\\n');
end

disp('% ------ End of Matlab-generated LaTeX code ------')
