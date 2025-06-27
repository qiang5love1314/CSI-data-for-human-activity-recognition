%获取CSI矩阵，获取振幅值
function [csi_matrix]=get_csi_matrix(csi_trace)
    csi_matrix=zeros(3,30,400);
    for i = 1:size(csi_trace,1)
        csi_entry = csi_trace{i};
        csi = get_scaled_csi(csi_entry);
        csi_matrix(:,:,i) = squeeze(abs(csi));
    end
end