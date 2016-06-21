function table_with_max_per_col(data, row_names, col_names, col_max_min, row_groups)

ncols = size(data,2);
nrows = size(data,1);

if ~exist('row_groups','var')
    % The optimum values are computed within these sets of rows
    % (one id per group, e.g. [1 1 2 2 2 2] means two rows in one group, four in another)
    row_groups = ones(1,nrows);
end
if ~exist('col_max_min','var')
    % Define if each measure is good max or min
    col_max_min = ones(1,ncols);
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

% Get the maximum on each of the groups
n_groups = length(unique(row_groups));
max_ids = zeros(n_groups,ncols);
for jj=1:n_groups
    for ii=1:ncols
        if col_max_min(ii)
            tmp = data(:,ii); tmp(row_groups~=jj) = 0;
            [~, max_ids(jj,ii)] = max(tmp);
        end
    end
end

% Show the table
for ii=1:nrows
    % Display row name
    fprintf('%s%s%s', row_names{ii}, repmat(' ',1,padding_first-length(row_names{ii})), ampersan_first);

    for jj=1:ncols
        if data(ii,jj)<0, sp = ' '; else sp = '\ '; end
        if jj==1, amp = ''; else amp = ' &'; end
        if ismember(ii,max_ids(:,jj))
            fprintf('%s \\bf%s%0.3f%s', amp, sp, data(ii,jj), repmat(' ',1,padding(jj)-10));
        else
            fprintf('%s    %s%0.3f%s', amp, sp, data(ii,jj), repmat(' ',1,padding(jj)-10));
        end
    end
    fprintf(' \\\\\n');
end

disp('% ------ End of Matlab-generated LaTeX code ------')
