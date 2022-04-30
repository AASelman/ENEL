% With ReadC4File: Conversion function
% Dr. Ahmed A. Selman, October 2021
% This works for alpha file 
function [tE,tDE,tCS,tDCS]=C4Convrt(Indx,IndxSelect,OutInf,CSC4)
k5=0;
spot1=Indx(IndxSelect);
flagMns=0;
Yt=cell2mat(OutInf{9}(spot1));
fprintf('%s \n',['The selected Index is: ',Yt]);
fprintf('%s\n',['For Index value no. : ', num2str(IndxSelect)]);
NumLns=str2num(Yt(10:end));
for i=1:NumLns
    T1=cell2mat(CSC4(spot1,i));
    if ischar(T1)
        k5=k5+1;
     for j=1:numel(T1)
         if flagMns==1;flagMns=0;continue;end 
     switch T1(j)
         case '+'
             T1(j)='e';
         case '-' % zig zagy thing 
             T1(j)='e';
             tQ=T1(j+1);
             T1(j+1)='-';
             T1(j+2)=tQ;
             flagMns=1;
     end 
     end % Now it is supposed to have changed every + in T1 with e. 
     % And every - in T1 with e- with adding the next char. Eg -7==>e-7

      %if ~isempty(a1);disp('A1 Empty');end
      T1 ;
      size(T1);
      TR0=T1(1:19);
      TR1=T1(20:27);
      TR2=T1(28:36);
      TR3=T1(37:45);
      TR4=T1(46:54);
     a1=str2num(T1(23:30))  ;
     a2=str2num(T1(31:39))   ; 
     a3=str2num(T1(40:49))   ;
     a4=str2num(T1(50:58)) ;
 %    pause 
     if ~isempty(a1);tE(k5)=str2num(T1(22:30));else tE(k5)=0;end 
     if ~isempty(a2);tDE(k5)=str2num(T1(31:39));else tDE(k5)=0;end 
     if ~isempty(a3);tCS(k5)=str2num(T1(40:49));else tCS(k5)=0;end
     if ~isempty(a4);tDCS(k5)=str2num(T1(50:58));else tDCS(k5)=0;end
    else 
        break
    end 
end 