function [matrix]=CSI_STFT_30(csi_matrix)
    matrix=zeros(30,129,126);
    for i=1:30
        csi_e=squeeze(csi_matrix(1,i,:));
        [s,f,t,p]=spectrogram(csi_e,50,48,'MinThreshold',-40,'yaxis');
        p=10*log10(p)+40;
        p(p==-Inf)=0;
        p=p/50;
        matrix(i,:,:)=p;
    end
end