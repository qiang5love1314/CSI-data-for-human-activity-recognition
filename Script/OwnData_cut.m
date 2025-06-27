clear;clc;
DataFile='C:\Users\张立昀\Desktop\数据集\0512\sitting\zyy_sitting.dat';
SaveDir='C:\Users\张立昀\Desktop\DataSet\meetingroom\2\';
SaveFile='Zyy_sitting';
start=600;

csi_trace=read_bf_file(DataFile);


%检查是否有空包
lgth=size(csi_trace,1);
for i=1:lgth
        empty=isempty(csi_trace{i});
        if empty==1
            lgth=i-1;
            break;
        end
end

for k=1:20
    csi=zeros(3,30,200);
    for j=1:200
        index=start+j;
        csi_entry=csi_trace{index};
        csi_data=get_scaled_csi(csi_entry);
        csi(:,:,j)=squeeze(csi_data);
    end
    start=start+300;
    SaveNameTmp=[SaveFile int2str(k)];
    SaveName=[SaveNameTmp '.mat'];
    save([SaveDir SaveName],'csi');
end
