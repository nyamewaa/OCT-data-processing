%Lab 2 
%1
tape_proc= imread('OCTImage__7.png');
tape_raw =imread('OCTImage__7_RAW.tif');
tape_BG= imread('OCTImage__7_RAW_BG.tif');

%2 
tape_avg = mean(tape_BG,1); 
tape_sub = zeros(size(tape_raw)); 
for ii=1:size(tape_raw,1)
    tape_sub(ii,:) = double(tape_raw(ii,:))-tape_avg;
end 

%3
p=0:2047; 
c0=742.856;
c1=9.56435e-2; 
c2=-2.35188e-6; 
c3=-1.24951e-10; 

lamda=c0+(c1.*p)+(c2.*p.^2)+(c3.*p.^3); 

%4 
k1=2*pi./lamda(end); 
k2048=2*pi./lamda(1); 

k_space= linspace(k1,k2048,2048); 

%5 
n=linspace(-1,1,2048);
E2=.05;
E3=.3; 

D=exp(-i.*(E2.*n.^2+E3.*n.^3)); 

tape_phaseAdj = zeros(size(tape_sub)); 
for ii=1:size(tape_sub,1)
    tape_phaseAdj(ii,:) = D.*tape_sub(ii,:);
end 

%6 
tape_phaseMag= abs(tape_phaseAdj); 

%7
tape_Log=20*log10(tape_phaseMag); 
figure();
imagesc(tape_Log,[-60,0])
colormap gray;