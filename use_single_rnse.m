function [ result_all ] = use_single_rnse( name,roundtime )
%USE_SINGLE_RNSE 
%This function would run RNSE roundtime times on the dataset with the 'name' inputed. 
%Output is mean and std of acc, NMI and purity.
%get data  
data_name=name
[data,gt]=data_fetch(name);
gt=gt-(min(gt));
cluster_num= length(unique(gt))
%data get part end

times10 = zeros(roundtime,3);
for j=1:roundtime  
    
    [ la,s,p ] = RNSE( data,cluster_num,1e0,1e0);
    la=la-(min(la));
    result = ClusteringMeasure(double(gt), double(la));
    times10(j,:) = result;
end

all_acc=times10(:,1);
all_nmi=times10(:,2);
all_purity=times10(:,3);
acc=mean(all_acc);
nmi=mean(all_nmi);
purity=mean(all_purity);
std_acc=std(all_acc);
std_nmi=std(all_nmi);
std_purity=std(all_purity);
label_old=la;
result_all=zeros(3,2);
result_all(1,1)=acc;
result_all(1,2)=std_acc;
result_all(2,1)=nmi;
result_all(2,2)=std_nmi;
result_all(3,1)=purity;
result_all(3,2)=std_purity;
save_pa=['rnse_test_result/',name];
save_path=[save_pa,'.mat'];
save(save_path,'all_acc','all_nmi','all_purity','acc','nmi','purity','std_acc','std_nmi','std_purity','label_old','s','p')
end

