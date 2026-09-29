%
% [MTD_Out, MTD_Max, Max_Index]= MTD(Input, NFFT, NPRI, PRF)
%
function [MTD_Out, MTD_Max, Max_Index]= MTD(Input, NFFT, PRF, NPRI)

% NFFT = 32;
% NPRI = 200;
% PRF = 1000;

% Boundary Check;
if (NPRI < 1);
    error('NPRI should be greater than 0');
    NPRI = 1;
end;
if (NFFT < 1);
    error('NFFT should be greater than 0');
    NFFT = 1;
end;
MTD_Out = zeros(NPRI*NFFT, 1);
tmp_out = zeros(NPRI, NFFT);
MTD_Max = zeros(NPRI, 1);
Max_Index = zeros(NPRI, 1);
%R_Input = reshape(Input,NPRI,NFFT);
R_Input = zeros(NPRI,NFFT);
%index=1;
% for j=1:NFFT;
%     R_Input(1:NPRI,j) = Input(index:index+NPRI-1);
%     index = index + NPRI;
% end;
index=0;
for k=1:NFFT;
    for l=1:NPRI;
        R_Input(l,k) = Input(index+l);
    end
    index = index + NPRI;
end;
for i=1:NPRI;
    s_temp = R_Input(i,:);
    tmp_out(i,:) = fft(s_temp,NFFT);
    [tmp, J] = max(tmp_out(i,:));
    MTD_Max(i)=tmp;
    Max_Index(i)= (J-1)*PRF/NFFT;  % this factor converts index to freq  1000 is the PRF
    %Max_Index(1,i)=J;
end;
index = 1;
for j=1:NPRI;
    MTD_Out(index:(index+NFFT-1)) = tmp_out(j,1:NFFT).';
    index = index + NFFT;
end;