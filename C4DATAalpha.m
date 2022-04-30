% REF! IT WORKS with He projctile
% With ReadC4File:  
% Dr. Ahmed A. Selman, October 2021
% This function extracts reaction data only. The data should be found
% between the hashtages #DATA and #/DATA at each portion of the input C4
% file.
% I isolated this from ReadLineC4.m function to simplify things.
% 16 Oct. 2021 Done. Now ALL the data values are summed in CSC4.
% DONE!!!! 
% CSC4 is where cross-section data of wanted parts are stored.
% ReacData is where parts of data of wanted parts are stored.
function [CSC4,ReacData,Faild1]=C4DATAalpha(txt,FileName)
fid=fopen(FileName,'r');
y = 0;
dumpflag=0;
Faild1=0;
tline = fgetl(fid);
k=0;numZ=0;
zz=0; 
if zz~=0;
    zdim=zz+1;
else
zdim=1;
end 
while ischar(tline)
   matches = strfind(tline, txt);
   num = length(matches);
   if num > 0
      y = y + num;
%       fprintf('%d:%s\n',y,tline) 
      k=k+1;
      Tout{k}=tline;
      Yout(k)=y;
      b1=regexp(tline,'#DATA ');
% Here 
if b1==1;
          t1=fscanf(fid,'%c',133);
          t2=fscanf(fid,'%c',133);
          t3=fscanf(fid,'%c\n',1);
          %pause 
          z1=1; % flag for #/DATA
          k4=0;% dim for data1
          while z1
          ReacData{k,:}=fscanf(fid,'%c',[1,131]);
          t33=fscanf(fid,'%c\n',1);
          T0=ReacData{k,:};
          if numel(T0)==0
              %if dumpflag==1;disp('Exit!!');break;end 
              disp('changing limit')
              %dumpflag=1;
              %dump1=fscanf(fid,'%c\n',[1,131])
              %ReacData{k,:}=fscanf(fid,'%c',[1,133])
           
              break
          else 
          b2=strcmp(T0(1:9),'#/DATA   ');
          k4=k4+1; 
          if b2==1;
              zdim=zdim+1;
  %            disp('END!!!!!!!!!!!!')
              zz=zdim+1;
              numZ=numZ+1;
              break
          else 
              CSC4{zdim,k4}=T0;
          end
          end % T0
          end % while z1
         
      end 
% and Here
   end
   tline = fgetl(fid);
end
fclose(fid);
end 
