%获取短时傅里叶变换频谱图
function [matrix]=CSI_STFT(csi_matrix)
    csi_1=squeeze(csi_matrix(1,1,:));
    csi_2=squeeze(csi_matrix(1,15,:));
    csi_3=squeeze(csi_matrix(1,30,:));
    [s1,f1,t1,p1]=spectrogram(csi_1,50,48,'MinThreshold',-30,'yaxis');
    [s2,f2,t2,p2]=spectrogram(csi_2,50,48,'MinThreshold',-30,'yaxis');
    [s3,f2,t2,p3]=spectrogram(csi_3,50,48,'MinThreshold',-30,'yaxis');
    
    p1=10*log10(p1)+30;
    p2=10*log10(p2)+30;
    p3=10*log10(p3)+30;
    p1(p1==-Inf)=0;
    p2(p2==-Inf)=0;
    p3(p3==-Inf)=0;
    p1=p1/40;
    p2=p2/40;
    p3=p3/40;
    
    matrix=zeros(3,129,126);
    matrix(1,:,:)=p1;
    matrix(2,:,:)=p2;
    matrix(3,:,:)=p3;
end
    