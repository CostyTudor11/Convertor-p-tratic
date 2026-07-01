clear all; close all; clc;

syms Vg D fs R LM C VC ILM dVo Ron n
syms Vo Po positive

Eq1=D*(Vg-VC-ILM*Ron)+(1-D)*((VC-Ron*ILM/n)/n);
Eq2=D*(ILM-VC/R)+(1-D)*(-ILM-VC/R); 


solutia=solve(Eq1,Eq2,VC,ILM);
VC=simplify(solutia.VC),pretty(VC),
ILM=simplify(solutia.ILM),pretty(ILM),

