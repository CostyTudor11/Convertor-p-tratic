
% % Pct. 10. Calculul valorilor medii ale tensiunilor capacitive si
% % curentilor inductivi in cazul cu pierderi

clear all; close all; clc;

syms Vg D fs R L1 L2 C1 C2 VC1 VC2 IL1 IL2 Vo dVo Mreal Mid
syms Ron VD2 VD3 VD4 RC2
Ron=0; VD2=0; VD3=0; VD4=0; RC2=0;

Rp=R*RC2/(R+RC2);

Voon=(IL2)*Rp+VC2*R/(R+RC2);
VL1on=Vg-IL1*Ron;
VL2on=VC1-VD3-Voon;
IC1on=-IL2;
IC2on=(IL2)*R/(R+RC2)-VC2/(R+RC2);

Vooff=IL1*Rp+VC2*R/(R+RC2);
VL1off=Vg-Vooff-VD4-VC1-VD2;
VL2off=VC1+VD4;
IC1off=IL1-IL2;
IC2off=IL1*R/(R+RC2)-VC2/(R+RC2);

Eq1=D*VL1on+(1-D)*VL1off;
Eq2=D*VL2on+(1-D)*VL2off;
Eq3=D*IC1on+(1-D)*IC1off;
Eq4=D*IC2on+(1-D)*IC2off;

solutia=solve(Eq1,Eq2,Eq3,Eq4,VC1,VC2,IL1,IL2);
VC1=simplify(solutia.VC1),pretty(VC1),
VC2=simplify(solutia.VC2),pretty(VC2),
IL1=simplify(solutia.IL1),pretty(IL1),
IL2=simplify(solutia.IL2),pretty(IL2), 

% % Verificare valorilor medii ale tensiunilor capacitive, curentilor
% % inductivi si M in cazul ideal

Ron=0; VD2=0; VD3=0; VD4=0; RC2=0;
VC1id=simplify(eval(VC1)),
VC2id=simplify(eval(VC2)),
IL1id=simplify(eval(IL1)),
IL2id=simplify(eval(IL2)),

Mreal=VC2/Vg,
Mid=simplify(eval(Mreal)),

% % Pct. 10. Calculul literal al factorului de umplere pentru cazul cu pierderi

D=solve(VC2-Vo, D),
% %root(R*RC2*VD4*z^4 + R*RC2*VD3*z^4 + R^2*Vo*z^4 + R^2*VD4*z^4 + R^2*VD3*z^4 - R*RC2*VD4*z^3 - R*RC2*VD3*z^3 - R^2*VD4*z^3 - R^2*VD3*z^3 + R*RC2*Vo*z^3 + R*RC2*VD2*z^3 + R^2*VD2*z^3 - 2*R*RC2*Vo*z^2 - R*RC2*VD4*z^2 - R*RC2*VD3*z^2 - R*RC2*VD2*z^2 - 2*R^2*Vo*z^2 - R^2*VD4*z^2 - R^2*VD3*z^2 - R^2*VD2*z^2 + R*RC2*Vg*z^2 + R^2*Vg*z^2 - R*RC2*VD2*z - R^2*VD2*z + RC2*Ron*Vo*z + R*Ron*Vo*z + R*RC2*VD4*z + R*RC2*VD3*z + R^2*VD4*z + R^2*VD3*z - R*RC2*Vg - R^2*Vg + R*RC2*Vo + R*RC2*VD2 + R^2*Vo + R^2*VD2, z, 1)
syms z
% % a=simplify(prima expresie lui D din linia de mai sus)
a=simplify(R^2*VD2 - R^2*Vg + R^2*Vo - R^2*VD2*z^2 + R^2*VD2*z^3 - R^2*VD3*z^2 - R^2*VD3*z^3 - R^2*VD4*z^2 + R^2*VD3*z^4 - R^2*VD4*z^3 + R^2*VD4*z^4 + R^2*Vg*z^2 - 2*R^2*Vo*z^2 + R^2*Vo*z^4 + R*RC2*VD2 - R*RC2*Vg + R*RC2*Vo - R^2*VD2*z + R^2*VD3*z + R^2*VD4*z - R*RC2*VD2*z^2 + R*RC2*VD2*z^3 - R*RC2*VD3*z^2 - R*RC2*VD3*z^3 - R*RC2*VD4*z^2 + R*RC2*VD3*z^4 - R*RC2*VD4*z^3 + R*RC2*VD4*z^4 + R*RC2*Vg*z^2 - 2*R*RC2*Vo*z^2 + R*RC2*Vo*z^3 - R*RC2*VD2*z + R*RC2*VD3*z + R*RC2*VD4*z + R*Ron*Vo*z + RC2*Ron*Vo*z)
p=collect(a,z),

% % Calcul numeric pentru Pct. 10+11
Vgmin=8; Vgmax=12; Vo=15; Pomin=10; Pomax=15; fs=80e3; dVo=100e-3;
Vg=Vgmax;  R=Vo^2/Pomax,

% % Valorile elementelor de pierderi pentru componente
Ron=100e-3;  VD2=0.7; VD3=0.7; VD4=0.7; RC2=15e-3;
 a4=(R^2*VD3 + R^2*VD4 + R^2*Vo + R*RC2*VD3 + R*RC2*VD4);
 a3=(R^2*VD2 - R^2*VD3 - R^2*VD4 + R*RC2*VD2 - R*RC2*VD3 - R*RC2*VD4 + R*RC2*Vo);
 a2=(R^2*Vg - R^2*VD3 - R^2*VD4 - R^2*VD2 - 2*R^2*Vo - R*RC2*VD2 - R*RC2*VD3 - R*RC2*VD4 + R*RC2*Vg - 2*R*RC2*Vo);
 a1=(R^2*VD3 - R^2*VD2 + R^2*VD4 - R*RC2*VD2 + R*RC2*VD3 + R*RC2*VD4 + R*Ron*Vo + RC2*Ron*Vo);
 a0=(R^2*VD2 - R^2*Vg + R^2*Vo + R*RC2*VD2 - R*RC2*Vg + R*RC2*Vo);
 D=roots([a4 a3 a2 a1 a0])

%  % Pct. 11. Reprezentarea raportului static de conversie M=f(D, convertor ideal si convertor cu pierderi de conductie

% % Vg=Vgmax;
Duty=0.01:0.01:0.99;
for i=1:length(Duty);
    D=Duty(i);
Mid(i)=1./(1-D.^2.); % se modifica expresia lui M ideal de la conv. la conv. 
Mreal(i)=-(R*(D^2 - 1)*(R + RC2)*(Vg - VD2 + D^2*VD3 + D^2*VD4 + D*VD2 - D*VD3 - D*VD4))/(Vg*(D^4*R^2 + RC2*D^3*R - 2*D^2*R^2 - 2*RC2*D^2*R + Ron*D*R + RC2*Ron*D + R^2 + RC2*R)); %se modifica expresia lui M real de la conv. la conv. 
end
figure; plot(Duty, Mid,  Duty, Mreal); hold on;  title('Raportul Static de Conversie Ideal si Real, M = f (D)'); xlabel('Factorul de umplere, D'); ylabel('Raportul Static de Conversie, M'); %grafic M ideal si M real in functie de D
axis([0 1 0 7]); % se modifica intervalul pentru M de la conv. la conv. cf. caracterului convertorului.

% % Calculul randamentului in 2 (Rc nenul),3 (Rc=0) moduri, in ipoteza pulsatiilor mici

D=0.5012;Vo=15; Pomax=15;Pomin=10;Vg=12;Vgmax=12; VD2=0.7;VD3=0.7;VD4=0.7;
Ron=100e-3;RC2=15e-3;dVo=100e-3;
R=Vo^2/Pomax;
Rp=R*RC2/(R+RC2);
Voon=(IL2)*Rp+VC2*R/(R+RC2);
Vooff=IL1*Rp+VC2*R/(R+RC2);
Vorms=eval(sqrt(D*Voon^2+(1-D)*Vooff^2));
IC2on=(IL2)*R/(R+RC2)-VC2/(R+RC2);
IC2off=IL1*R/(R+RC2)-VC2/(R+RC2);
IC2rms=eval(sqrt(D*IC2on^2+(1-D)*IC2off^2));

Ig=IL1;
Ig=eval(Ig);

Po=Vorms^2/R;
Pg=Vg*Ig;

% Pierderile individuale
IQrms=eval(sqrt(D)*IL1);
ID2=eval((1-D)*IL1);
ID3=eval(D*(IL2));
ID4=eval((1-D)*(IL1-IL2));

PQ=IQrms^2*Ron,
PD2=VD2*ID2,
PD3=VD3*ID3,
PD4=VD4*ID4,
PC2=IC2rms^2*RC2,
% % Randamentul cu formula 1
eta1=Po/Pg*100,

% % Randamentul cu formula 2
eta2=(Po/(Po+PQ+PD2+PD3+PD4+PC2))*100,

dif12=(eta1-eta2),

% % Randamentul cu formula 3 - doar cand Rc=0
% % Mreal=(-(R*(D^2 - 1)*(R + RC2)*(Vg - VD4 + D^2*VD2 + D^2*VD3 - D*VD2 - D*VD3 + D*VD4))/(Vg*(D^4*R^2 + RC2*D^3*R - 2*D^2*R^2 - 2*RC2*D^2*R + Ron*D*R + RC2*Ron*D + R^2 + RC2*R))),
RC2=0;
% % VC2=double(subs(solutia.VC2));
Mid=1/(1-D^2);

eta3=Mreal/Mid*100,

dif13=(eta1-eta3),
eta1g=Po/Pg;
Mpierderi=VC2/Vg, pretty(Mpierderi);

Duty=0.01:0.01:0.99;
for i=1:length(Duty)
    D=Duty(i);
    Voon=(IL2)*Rp+VC2*R/(R+RC2);
    Vooff=IL1*Rp+VC2*R/(R+RC2);
    Vorms=eval(sqrt(D*Voon^2+(1-D)*Vooff^2));

    IC2on=(IL2)*R/(R+RC2)-VC2/(R+RC2);
    IC2off=IL1*R/(R+RC2)-VC2/(R+RC2);
    IC2rms=eval(sqrt(D*IC2on^2+(1-D)*IC2off^2));

    Ig=IL1;
    Ig=eval(Ig);

    Po=Vorms^2/R;
    Pg=Vg*Ig;

% % Pierderile individuale
    IQrms=eval(sqrt(D)*IL1);
    ID2=eval((1-D)*IL1);
    ID3=eval(D*(IL2));
    ID4=eval((1-D)*(IL1-IL2));

    PQ=IQrms^2*Ron;
    PD2=VD2*ID2;
    PD3=VD3*ID3;
    PD4=VD4*ID4;
    PC2=IC2rms^2*RC2;

    eta1(i)=Po/Pg*100;
    eta2(i)=(Po/(Po+PQ+PD2+PD3+PD4+PC2))*100;
    
    Mreal(i)=(-(R*(D^2 - 1)*(R + RC2)*(Vg - VD4 + D^2*VD2 + D^2*VD3 - D*VD2 - D*VD3 + D*VD4))/(Vg*(D^4*R^2 + RC2*D^3*R - 2*D^2*R^2 - 2*RC2*D^2*R + Ron*D*R + RC2*Ron*D + R^2 + RC2*R)));
    Mid(i)=1/(1-D^2);
    eta3(i)=Mreal(i)/Mid(i)*100;
end

figure; plot(Duty,eta1,'r');title('Randamentul, Eta1 = f (D)'); xlabel('Factorul de umplere, D');ylabel('Randamentul, Eta1'); axis([0 1 0 100]); hold on
plot(Duty,eta2,'b');title('Randamentul, Eta2 = f (D)'); xlabel('Factorul de umplere, D');ylabel('Randamentul, Eta2'); hold on;
plot(Duty,eta3,'g');title('Randamentul, Eta3 = f (D)'); xlabel('Factorul de umplere, D');ylabel('Randamentul, Eta3');


