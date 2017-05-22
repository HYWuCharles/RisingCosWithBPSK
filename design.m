function b1 = design(Fd,Fs,TYPE_FLAG,R)
N = 50;
sps = Fs/(2*Fd);
span = N/sps;

b1 = rcosdesign(R,span,sps,TYPE_FLAG);

end