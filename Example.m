%Example of using RNSE, put data in the 'test_data' file. The output will
%be saved in 'rnse_test_result'
maindir = 'test_data';
subdir  = dir( maindir );
parfor i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' )||...
        isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir)               % check file name
        continue;
    end
    name = subdir( i ).name;
    a = strfind(name,' ');
    if size(a,1)~=0
        name = name(1:a(1)-1);
    end
    [data,gt]=data_fetch(name);
    result_all  = use_single_rnse( name ,2);     %call the  use_single_rnse function '2' means the function would be run 2 times and the output would include the mean and std.
end
