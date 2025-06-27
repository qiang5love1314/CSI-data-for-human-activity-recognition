%获取CSI矩阵（振幅值）
function [csi_mat]=get_csi_matrix_sized(csi_trace,lgth)
    %csi_matrix=zeros(3,30,300);
    %此处为了VGG网络统一尺寸进行修改3*120*300
    %csi_matrix=zeros(3,120,300);
    csi_mat=zeros(3,30,300);
    length=lgth;
    %包数大于设定值（300）的，直接裁剪
    if length>300
        start=floor(length/2)-150;
        csi_matrix_orgin1=zeros(30,300);%天线1
        csi_matrix_orgin2=zeros(30,300);%天线2
        csi_matrix_orgin3=zeros(30,300);%天线3
        for j = 1:300
            index=j+start;
            csi_entry = csi_trace{index};
            csi = get_scaled_csi(csi_entry);
            csi_matrix_orgin1(:,j) = squeeze(abs(csi(1,1,:)));
            csi_matrix_orgin2(:,j) = squeeze(abs(csi(1,2,:)));
            csi_matrix_orgin3(:,j) = squeeze(abs(csi(1,3,:)));
            
            for k=1:30
                csi_mat(1,k,:) = csi_matrix_orgin1(k,:);%此处为适应尺寸进行修改
                csi_mat(2,k,:) = csi_matrix_orgin2(k,:);
                csi_mat(3,k,:) = csi_matrix_orgin3(k,:);
            end
        end
        
        %归一化
        csi_mat(1,:,:)=mapminmax(squeeze(csi_mat(1,:,:)),0,1);
        csi_mat(2,:,:)=mapminmax(squeeze(csi_mat(2,:,:)),0,1);
        csi_mat(3,:,:)=mapminmax(squeeze(csi_mat(3,:,:)),0,1);
        
        
    %包数小于设定值（300）的，插值补齐
    elseif length<300
        csi_matrix_orgin1=zeros(30,size(csi_trace,1));%天线1
        csi_matrix_orgin2=zeros(30,size(csi_trace,1));%天线2
        csi_matrix_orgin3=zeros(30,size(csi_trace,1));%天线3
        for j = 1:lgth
            csi_entry = csi_trace{j};
            csi = get_scaled_csi(csi_entry);
            csi_matrix_orgin1(:,j) = squeeze(abs(csi(1,1,:)));
            csi_matrix_orgin2(:,j) = squeeze(abs(csi(1,2,:)));
            csi_matrix_orgin3(:,j) = squeeze(abs(csi(1,3,:)));    
        end
        %插值补齐
        for k=1:30%此处为适应尺寸进行修改
            csi_mat(1,k,:)=interp1(csi_matrix_orgin1(k,:)',1:(size(csi_trace,1)-1)/299:size(csi_trace,1));
            csi_mat(2,k,:)=interp1(csi_matrix_orgin2(k,:)',1:(size(csi_trace,1)-1)/299:size(csi_trace,1));
            csi_mat(3,k,:)=interp1(csi_matrix_orgin3(k,:)',1:(size(csi_trace,1)-1)/299:size(csi_trace,1));
        end
        %归一化
        csi_mat(1,:,:)=mapminmax(squeeze(csi_mat(1,:,:)),0,1);
        csi_mat(2,:,:)=mapminmax(squeeze(csi_mat(2,:,:)),0,1);
        csi_mat(3,:,:)=mapminmax(squeeze(csi_mat(3,:,:)),0,1);
    end
    
    %for l=1:30%此处为适应尺寸进行修改
    %    csi_matrix(:,l,:)=csi_mat(:,l,:);
    %    csi_matrix(:,l+30,:)=csi_mat(:,l,:);
    %    csi_matrix(:,l+60,:)=csi_mat(:,l,:);
    %    csi_matrix(:,l+90,:)=csi_mat(:,l,:);
    %end
end