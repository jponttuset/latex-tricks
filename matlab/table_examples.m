
data      = rand(4,5);
row_names = {'Row 1', 'Row with long name', 'Row 3', 'Row 4'};
col_names = {'Column 1', 'Colum with long name', 'Column 3', 'Column 4', 'Column 5'};

clc
table_with_max_per_row(data, row_names, col_names);
table_with_max_per_col(data, row_names, col_names);
