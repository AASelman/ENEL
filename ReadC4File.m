% 9th Oct 2021 ReadC4File.m for reading C4 raw data file from EMPIRE output 
% The following function was modified from example in MATLAB HELP: 
% Import Text Data Files with Low-Level I/O
% 12th Oct 2021 today I cold select the exact reaction I need using
% REACTION, MF nd MT fields from C4 data.
% 15th Oct 2021 @ 2:00 amNow I have isolated the portions where data are 
% found, I mean the porition between #DATA and #/DATA in the C4 file.
% NEXT: (1) I want to read the data in clear form i.e. to separate the
% cross section, cross section presicion, and energy; from the rest of the 
% things listed in the #DATA <--> #DATA part.
% (2)I want to read NOT all DATA, but read only those matching :
% reaction type, MF and MT. 
% 20th Oct. 2021. After few days of work I think the code is now ready.
% Yo Estoy Feliz!
% This is the main calling program. It calles:
% 1: ReadLine.m function
% 2: SelectDataC4.m function
% 3: C4DATA.m function 
% 4: plotC4data.m functiion -- > and this calls C4Convrt.m function
% So: there are FIVE subfunctions with this code.
clear 
clc
close all
% 1: The code below finds the header and arranges it 
% 2: USER INPUT is here
TXT={'#ENTRY' '#AUTHOR1' '#YEAR' '#TITLE' '#REFERENCE' '#REACTION' '#MF'...
     '#MT' '#DATA '}; % '#DATA ' 
%FileID='C:\wrk\C13_alpha_n\C13_alpha_n_1-raw.c4' ;
%FileID='D:\Empire3.2.2\EMPIRE-3.2.2\EXFOR\alphas\006_C_013.c4'; % user input 
FileID='D:\Empire3.2.2\EMPIRE-3.2.2\EXFOR\alphas\009_F_019.c4'; % user input 

ReacMF='#MF         3';% this should be user input 
ReacMT='#MT         4';% this should be user input 
ReacTyp='#REACTION   9-F-19(A,N)';%6-C-13(A,N)';


% n-H
%FileID='D:\Empire3.2.2\EMPIRE-3.2.2\EXFOR\neutrons\001_H_003.c4'; % user input  
%ReacTyp='#REACTION   1-H-3(N,TOT)';
%ReacMF='#MF         3';% this should be user input 
%ReacMT='#MT         1';% this should be user input 
 

 % lpha-K
%FileID='D:\Empire3.2.2\EMPIRE-3.2.2\EXFOR\alphas\019_K_041.c4';
%ReacTyp='#REACTION   19-K-41(A,N)';
%ReacMF='#MF         3';% this should be user input 
%ReacMT='#MT         4';% this should be user input 
%FileID='D:\Empire3.2.2\EMPIRE-3.2.2\EXFOR\alphas\050_Sn_000.c4';
%FileID='D:\Empire3.2.2\EMPIRE-3.2.2\EXFOR\alphas\002_He_004.c4';
%ReacTyp='#REACTION   6-C-13(A,N)'; % this should be user input 
          
% ReacTyp='#REACTION   2-HE-4(A,EL)'; % this should be user input 
%ReacMF='#MF         3';% this should be user input 
%ReacTyp= '#REACTION   50-SN-0(A,X)'; % Length should be 24 min char, case sensetive!
%ReacTyp='#REACTION   6-C-13(A,N)';
% ReacTyp= '#REACTION   19-K-41(A,2P)';
         %#REACTION   6-C-13(A,N)
         %#REACTION   19-K-41(A,2
%ReacMT='#MT         4';% this should be user input 
%ReacMF='#MF         3';% this should be user input 
%ReacMT='#MT         4';% this should be user input 
% 3: Reding main data parts 
for i=1:numel(TXT)
    txt=TXT{i};
    [y,tline1]=ReadLineC4(txt,FileID);% Read content of specified sections 
    Y(i,:)=y; % number of isolated data sections each section starts with 
    % the #ENTRY and ends with #/ENTRY lables.
    OutInf{i,:}=tline1;% All useful data defined by TXT
end
% 4: Selecting useful data:
[ReacNo,MFNo,MTNo,Indx]=SelectDataC4(y,OutInf,ReacTyp,ReacMF,ReacMT);
if isempty(Indx);
    fprintf('\n%s\n','Check your RECTION, MF and MT input values! Program Stopped in Main (ReadC4File.m).');
    break
end 
% 5: ReacNo: is the number of REACTIONS specified by ReacTyp above
% MFNo: is the number of MF specified by ReacMF above 
% MTNo: is the number of MT specified by ReacMT above 
% Indx: is the number of indecies (parts) of the file where we find matches
% of REACTION, MF and MT. 
fprintf('\n%s\n','Reading the file was successful!.');
fprintf('\n%s\n','Press any kwy to proceed.');
pause 

fprintf('%s%d\n','No of matched reactions found: ',ReacNo,...
    'No of matched MF found: ',MFNo,...
    'No of matched MT found: ',MTNo);
F4=['Index of required data (from user input) is: ',num2str(Indx)];
fprintf('%s %d\n\n',F4,'')

fprintf('%s\n\n','Those are: ')
% 6: Printing Summery:
% 7: Reading data. CSC4 is where cross-section data of wanted parts are stored.
%C4DATA
 [CSC4,ReacData,Faild1]=C4DATAalpha('#DATA ',FileID); % Exctraction of Data.
 
% [CSC4,ReacData,Faild1]=C4DATAneutron('#DATA ',FileID); % Exctraction of Data.
if Faild1==1;
    disp('ERRR!')
    break
end 
% 8: Select the part required to be read:
[E,DE,CrsSec,DCrsSec,IndxSelect,Mindx]=plotC4data(Indx,OutInf,...
    CSC4,ReacMF,ReacMT);