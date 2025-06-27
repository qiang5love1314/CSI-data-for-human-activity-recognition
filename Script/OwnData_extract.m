clear;clc;
LoadDirectory='C:\Users\张立昀\Desktop\数据集\0510\sit down\';
SaveDirectory='C:\Users\张立昀\Desktop\DataSet\bedroom\9\';
CSI_files=dir(fullfile(LoadDirectory,'yingying*'));
SaveFile='Zyy_sitdown';

for index=1:length(CSI_files)
    file_name=CSI_files(index).name;
    data_file=[LoadDirectory file_name];
    csi_trace=read_bf_file(data_file);
    lgth=size(csi_trace,1);
    
    %检查csi_trace空值
    for i=1:lgth
        empty=isempty(csi_trace{i});
        if empty==1
            lgth=i-1;
            break;
        end
    end
    if lgth>200
        csi=zeros(3,30,200);
        start=floor(lgth/2)-100;
        for j=1:200
            dex=start+j;
            csi_entry=csi_trace{dex};
            csi_data=get_scaled_csi(csi_entry);
            csi(:,:,j)=squeeze(csi_data);
        end
        
        save_name=[SaveFile int2str(index)];
        SaveName=[save_name '.mat'];
        save([SaveDirectory SaveName],'csi');  
    end
end