clear;clc;
LoadDirectory='C:\Users\张立昀\Desktop\project\Data set\WiAR_changed\1\';
SaveDirectory='C:\Users\张立昀\Desktop\project\Data_Process\data_process_file\3\';
CSI_files=dir(fullfile(LoadDirectory,'csi*'));
num=0;
for index=1:length(CSI_files)
    file_name=CSI_files(index).name;
    data_file=[LoadDirectory file_name];
    csi_trace=read_bf_file(data_file);
    lgth=size(csi_trace,1);
    %
    %检查csi_trace空值
    for i=1:lgth
        empty=isempty(csi_trace{i});
        if empty==1
            lgth=i-1;
            break;
        end
    end
    if lgth>240&&lgth<420
        num=num+1;  
    end
end