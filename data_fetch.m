function [ data_nd,grla ] = data_fetch( name )
%DATA_FETCH function to fetch data 
%   This function would fetch data from 'test_data' file, including d*n
%   sample matrix and 1*n lable.
        pre_fix='test_data/';
        name1=[name,'/'];
        name2=[name1,name];
        mat_name=[name2,'.mat'];
        path=[pre_fix,mat_name];
        mat_stru=load(path);
        data=mat_stru.(name);
        data = double(data);
        grla=mat_stru.('label');
        
        [m,n]=size(data);
        data_n=zeros(1,n);
        for i=1:n
            data_n(1,i)=norm(data(:,i));
        end
        data_n_all=repmat(data_n,m,1);
        data_nd=data./data_n_all;

end

