function [modSig,codedSig,st] = convPSK(inp, tr, st, M, Fd, Fs)
% Convolutionally encodes inp, then M-PSK modulates it.
[codedSig,st]=convenc(inp, tr, st)
if M~=2
    mArySig=bi2de(vec2mat(codedSig,fix(log2(M))),'left-msb')
    modSig=dmodce(mArySig, Fd, Fs, 'psk', M)
else
    modSig=dmodce(codedSig, Fd, Fs, 'psk', M)
end
%modSig=rcosflt(modSig,Fd,Fs,'fir/sqrt',0.35,2)

