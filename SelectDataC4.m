% With ReadC4File: Pre-Selection function
% Dr. Ahmed A. Selman, October 2021
% This function is to select the data of only REACTION, MT AND MF.
% 15 Oct. Done!
% 16th Oct. 2021 I checked the results after modifying the input data file
% and everything is cool.
% k1=ReacNo: is the number of REACTIONS specified by ReacTyp above
% k2=MFNo: is the number of MF specified by ReacMF above 
% k3=MTNo: is the number of MT specified by ReacMT above 
% Indx: is the number of indecies (parts) of the file where we find matches
% of REACTION, MF and MT. 
function [k1,k2,k3,Indx]=SelectDataC4(y,OutInf,ReacTyp,ReacMF,ReacMT)
Indx=[];k1=0;k2=0;k3=0;k0=0;
for i=1:max(y);
    reacTxt(i)=OutInf{6}(i)';
    MFTxt(i)=OutInf{7}(i)';
    MTTxt(i)=OutInf{8}(i)';
    DatTxt(i)=OutInf{9}(i)';
end
% Indx is the matrix where indices of mathced data are found. 
sizeRe=max(size(ReacTyp));
sizeMF=max(size(ReacMF));
sizeMT=max(size(ReacMT));

for i=1:max(y);
    C4Reac=cell2mat(reacTxt(i));
    n=max(size((C4Reac)));
    cCom=C4Reac(1:sizeRe);    
    v1=strcmp(ReacTyp,cCom); % This is to check reaction type as required.
    if v1==1;
    k1=k1+1; % no of matched REACTIONS
    C4MF=cell2mat(MFTxt(i));
    if size(C4MF)~=sizeMF;
        fprintf('\n%s\n','Check your RECTION, MF and MT input values! Program Stopped in SelectDataC4 in MF.');
    break
    end 
    cMF=C4MF(1:sizeMF);
    v2=strcmp(ReacMF,cMF); % This is to check reaction MF.
    if v2==1;
        k2=k2+1; % no of matched MF and REACTINS 
        
        C4MT=cell2mat(MTTxt(i));
            if size(C4MT)~=sizeMT;
            fprintf('\n%s\n','Check your RECTION, MF and MT input values! Program Stopped in SelectDataC4 in MT.');
            break
            end 
        cMT=C4MT(1:sizeMT);
        v3=strcmp(ReacMT,cMT); % This is to check reaction MT.
        if v3==1;
            k3=k3+1;  % no of matched MT and MF and REACTIONS 
            k0=k0+1;
            Indx(k0)=i;
        end 
    end 
    end 
end 
end 
