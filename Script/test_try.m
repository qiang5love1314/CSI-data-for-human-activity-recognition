LoadDirectory='C:\Users\张立昀\Desktop\project\Data set\WiAR_changed\1\';
SaveDirectory='C:\Users\张立昀\Desktop\project\Data_Process\data_process_file\1\';
CSI_files=dir(fullfile(LoadDirectory,'csi*'));
num=0;
for i=1:length(CSI_files)
    file_name=CSI_files(i).name;
    data_file=[LoadDirectory file_name];
    csi_trace=read_bf_file(data_file);
    lgth=size(csi_trace,1);
    %b='The length of file is:%d\n';
    %fprintf(b,lgth);
    if lgth>240&&lgth<420
        csi_matrix=zeros(3,30,300);
        length=size(csi_trace,1);
        %包数大于设定值（300）的，直接裁剪
        if length>300
            start=floor(length/2)-150;
            for j = 1:300
                csi_entry = csi_trace{j+start};
                csi = get_scaled_csi(csi_entry);
                csi_matrix(:,:,j) = squeeze(abs(csi));
            end
        %包数小于设定值（300）的，插值补齐
        elseif length<300
            csi_matrix_orgin1=zeros(30,size(csi_trace,1));%天线1
            csi_matrix_orgin2=zeros(30,size(csi_trace,1));%天线2
            csi_matrix_orgin3=zeros(30,size(csi_trace,1));%天线3
            for j = 1:size(csi_trace,1)
                csi_entry = csi_trace{j};
                csi = get_scaled_csi(csi_entry);
                csi_matrix_orgin1(:,j) = squeeze(abs(csi(1,1,:)));
                csi_matrix_orgin2(:,j) = squeeze(abs(csi(1,2,:)));
                csi_matrix_orgin3(:,j) = squeeze(abs(csi(1,3,:)));
            end
            %插值补齐
            for k=1:30
                csi_matrix(1,k,:)=interp1(csi_matrix_orgin1(k,:)',1:(size(csi_trace,1)-1)/299:size(csi_trace,1));
                csi_matrix(2,k,:)=interp1(csi_matrix_orgin2(k,:)',1:(size(csi_trace,1)-1)/299:size(csi_trace,1));
                csi_matrix(3,k,:)=interp1(csi_matrix_orgin3(k,:)',1:(size(csi_trace,1)-1)/299:size(csi_trace,1));
            end
        end
        save_name=[file_name(1:end-4) '.mat'];
        save([SaveDirectory save_name],'csi_matrix');
        num=num+1;  
    end
end