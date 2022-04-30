% With ReadC4File: Plotting function
% Dr. Ahmed A. Selman, October 2021
function [EC4,Auth,E,DE,CrsSec,DCrsSec,IndxSelect,Mindx]=plotC4data(Indx,OutInf,...
    CSC4,ReacMF,ReacMT)
E=0;DE=0;CrsSec=0;DCrsSec=0;IndxSelect=0;Mindx=0;
for i9=1:numel(Indx)
    Re9=cell2mat(OutInf{6}(Indx(i9)));
    Ath9=cell2mat(OutInf{2}(Indx(i9)));
    Tit9=cell2mat(OutInf{4}(Indx(i9)));
    Ref9=cell2mat(OutInf{5}(Indx(i9)));
    Yr9=cell2mat(OutInf{3}(Indx(i9)));
    fprintf('%s%d\n','Part: ',i9,'');
    fprintf('%s%d\n','Secton: ',Indx(i9),'');
    fprintf('%4s\n',Re9,Ath9,Tit9,Ref9,Yr9);
    fprintf('%s\n\n','-----------------');
    Mindx(i9)=i9;
end 

for tr1=1:10 % gives user 10 chnces to plot.  
fprintf('\n%s\n','Select the Indx data ''Part'' you wish to polt.');
fprintf('\n%s\n','Allowed up to 10 times try. Press Enter (empty input) to stop.');
IndxSelect=input(''); % User nput. Can be made as interactive input.

if isempty(IndxSelect);
    fprintf('\n%s\n','Nothing was selected. End!');
    break
else 
    f0=find(IndxSelect==Mindx);
    if isempty(f0);
        fprintf('\n%s\n','The selected part does not exist. End!');
        break
    end 
end 
% 9: Gives us the cross section and energy and both their delta's:
[E,DE,CrsSec,DCrsSec]=C4Convrt(Indx,IndxSelect,OutInf,CSC4); % Final cross section!
% The cell below, called EC4, has cros sections and energies for output 
%This is added for neutron only
%------------------------------------------------------- --------   -
%- 18 - 4 - 2022 
EC4{tr1,1,:}=E;
EC4{tr1,2,:}=CrsSec;

% 10: Plot cross-section vs. E.
semilogy(E,CrsSec,'d-');
xlabel('Energy, eV','FontWeight','Bold');ylabel('Cross Section, b','FontWeight','Bold');
 Re10=cell2mat(OutInf{6}(Indx(IndxSelect)));
 Ath10=cell2mat(OutInf{2}(Indx(IndxSelect)));
 Tit10=cell2mat(OutInf{4}(Indx(IndxSelect)));
 Ref10=cell2mat(OutInf{5}(Indx(IndxSelect)));
 Yr10=cell2mat(OutInf{3}(Indx(IndxSelect)));
title({['For Reaction' Re9(10:end)],...
    ['Author:' Ath10(10:end),'.  Year:', Yr10(10:end),'.'],...
    ['MF:' ReacMF(10:end), '.   MT:', ReacMT(10:end),'.']},'FontWeight','Bold')
Auth{tr1,:}=Ath10;
end 
end 
 