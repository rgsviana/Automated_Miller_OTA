% Script projetar OTAs Miller com o Beta-Multiplier usando LUTs

% Este script é uma junção do lut_ota_miller e lut_reference

matlab_script_1_lut_loader

% Definições iniciais:

Vdd = 1.3;
Vds = Vdd/2;
Pt = 1000e-9;
Cl = 2e-12;  % Valor arbitrado para o capacitor de carga
Rref = 37e3; % Valor arbitrado para o resistor de referencia
n = 4; % Multiplicador da corrente pro beta-multiplier
W0 = 10;
L0 = 130;

% Projetando o OTA Miller:

L01 = L0*4;
L02 = L0*4;
L03 = L0*4;
L04 = L0*4;
L05 = L0*4;
L06 = L0*4;
L07 = L0*4;
L08 = L0*4;

Cc = Cl*0.25; % Capacitor de compensação

gm_id01 = 25; % Inversão fraca
gm_id02 = 25; % Inversão fraca
gm_id03 = 25; % Inversão fraca
gm_id04 = 25; % Inversão fraca
gm_id05 = 25; % Inversão fraca
gm_id06 = 25; % Inversão fraca
gm_id07 = 25; % Inversão fraca
gm_id08 = 25; % Inversão fraca
gm_id09 = 25; % Inversão fraca

Ibias = (Pt*n)/(Vdd*((5*n)+4));

Id08 = 2*Ibias;
Id05 = 2*Ibias;
Id06 = Ibias;

Id01 = Id05/2;
Id02 = Id05/2;
Id03 = Id01;
Id04 = Id02;
Id07 = Id06;
Id09 = Id08;

gm01 = Id01*gm_id01;
gm02 = Id02*gm_id02;
gm03 = Id03*gm_id03;
gm04 = Id04*gm_id04;
gm05 = Id05*gm_id05;
gm06 = Id06*gm_id06;
gm07 = Id07*gm_id07;
gm08 = Id08*gm_id08;
gm09 = Id09*gm_id09;

Rz = 1/gm01; % Resistor para retirar o zero

Jd01 = lut_finder2('P','id_w','vds',Vds,'L',L01,'gmid',gm_id01,lut_n,lut_p);
W01 = 1e6*Id01./Jd01;
Jd02 = lut_finder2('P','id_w','vds',Vds,'L',L02,'gmid',gm_id02,lut_n,lut_p);
W02 = 1e6*Id02./Jd02;
Jd03 = lut_finder2('N','id_w','vds',Vds,'L',L03,'gmid',gm_id03,lut_n,lut_p);
W03 = 1e6*Id03./Jd03;
Jd04 = lut_finder2('N','id_w','vds',Vds,'L',L04,'gmid',gm_id04,lut_n,lut_p);
W04 = 1e6*Id04./Jd04;
Jd05 = lut_finder2('P','id_w','vds',Vds,'L',L05,'gmid',gm_id05,lut_n,lut_p);
W05 = 1e6*Id05./Jd05;
Jd06 = lut_finder2('P','id_w','vds',Vds,'L',L06,'gmid',gm_id06,lut_n,lut_p);
W06 = 1e6*Id06./Jd06;
Jd07 = lut_finder2('N','id_w','vds',Vds,'L',L07,'gmid',gm_id07,lut_n,lut_p);
W07 = 1e6*Id07./Jd07;
Jd08 = lut_finder2('P','id_w','vds',Vds,'L',L08,'gmid',gm_id08,lut_n,lut_p);
W08 = 1e6*Id08./Jd08;

% Projetando o Beta-Multiplier:

L10 = L0*4;
L11 = L0*4;
L12 = L0*4;
L13 = L0*4;

gm_id10 = 23.5; % Inversão fraca
gm_id11 = 23.5; % Inversão fraca
gm_id12 = 23.5; % Inversão fraca
gm_id13 = 23.5; % Inversão fraca

Iref = Id09/n; % Valor de corrente que passa pelo resistor de referencia

Id13 = Iref;
Id12 = Id13;
Id11 = Id13;
Id10 = Id13;

gm10 = Id10*gm_id10;
gm11 = Id11*gm_id11;
gm12 = Id12*gm_id12;
gm13 = Id13*gm_id13;

Vr = Rref*Iref; % Valor de tensão sobre o resistor

Vds10 = Vdd/2;
Vds11 = (Vdd-Vr)/2;
Vds12 = Vdd/2;
Vds13 = (Vdd-Vr)/2;

Jd10 = lut_finder2('P','id_w','vds',Vds10,'L',L10,'gmid',gm_id10,lut_n,lut_p);
W10 = 1e6*Id10/Jd10;
Jd11 = lut_finder2('P','id_w','vds',Vds11,'L',L11,'gmid',gm_id11,lut_n,lut_p);
W11 = 1e6*Id11/Jd11;
Jd12 = lut_finder2('N','id_w','vds',Vds12,'L',L12,'gmid',gm_id12,lut_n,lut_p);
W12 = 1e6*Id12/Jd12;
Jd13 = lut_finder2('N','id_w','vds',Vds13,'L',L13,'gmid',gm_id13,lut_n,lut_p);
W13 = 1e6*Id13/Jd13;

W09 = W13*n;
L09 = L13;

% Ajuste dos valores dos componentes para o scrip .cir:

R1 = Rz*1e-3;

R2 = Rref*1e-3;

C1 = Cl*1e12;

C2 = Cc*1e12;

% Cálculo da área do circuito:

Area01 = (W01*1e-6)*(L01*1e-9);
Area02 = (W02*1e-6)*(L02*1e-9);
Area03 = (W03*1e-6)*(L03*1e-9);
Area04 = (W04*1e-6)*(L04*1e-9);
Area05 = (W05*1e-6)*(L05*1e-9);
Area06 = (W06*1e-6)*(L06*1e-9);
Area07 = (W07*1e-6)*(L07*1e-9);
Area08 = (W08*1e-6)*(L08*1e-9);
Area09 = (W09*1e-6)*(L09*1e-9);

Area_ota = Area01 + Area02 + Area03 + Area04 + Area05 + Area06 + Area07 + Area08 + Area09;

Area10 = (W10*1e-6)*(L10*1e-9);
Area11 = (W11*1e-6)*(L11*1e-9);
Area12 = (W12*1e-6)*(L12*1e-9);
Area13 = (W13*1e-6)*(L13*1e-9);

Area_beta = Area10 + Area11 + Area12 + Area13;

Area = (Area_ota+Area_beta)*1e12;

% Escrevendo o script para o NGSpice:

destino = 'ota_beta_13.cir';

fid = fopen(destino,'w');

fprintf(fid,'OTA Miller Combined with the Beta-Multiplier\n\n');
fprintf(fid,'*** ARQUIVOS DE MODELO ***\n');
fprintf(fid,'.include nmos130nm.pm\n');
fprintf(fid,'.include pmos130nm.pm\n\n');

fprintf(fid,'*** FONTES ***\n');
fprintf(fid,'vdd vdd 0 dc %f\n',Vdd);
fprintf(fid,'vss vss 0 dc 0\n');
fprintf(fid,'vip vip 0 dc %f ac 1\n',Vdd/2);
fprintf(fid,'vin vin 0 dc %f\n\n',Vds);

fprintf(fid,'*** MOSFETS ***\n');
fprintf(fid,'*M  D  G   S   B\n'); 
fprintf(fid,'m01 x2 vin x5  vdd pmos w=%fu l=%fn\n',W01,L01);
fprintf(fid,'m02 x3 vip x5  vdd pmos w=%fu l=%fn\n',W02,L01);
fprintf(fid,'m03 x2 x2  vss vss nmos w=%fu l=%fn\n',W03,L03);
fprintf(fid,'m04 x3 x2  vss vss nmos w=%fu l=%fn\n',W04,L03);
fprintf(fid,'m05 x5 x1  vdd vdd pmos w=%fu l=%fn\n',W05,L05);
fprintf(fid,'m06 x4 x1  vdd vdd pmos w=%fu l=%fn\n',W06,L06);
fprintf(fid,'m07 x4 x3  vss vss nmos w=%fu l=%fn\n',W07,L07);
fprintf(fid,'m08 x1 x1  vdd vdd pmos w=%fu l=%fn\n',W08,L08);
fprintf(fid,'m09 x1 x8  vss vss nmos w=%fu l=%fn\n',W09,L09);
fprintf(fid,'m10 x8 x6  vdd vdd pmos w=%fu l=%fn\n',W10,L10);
fprintf(fid,'m11 x6 x6  vdd vdd pmos w=%fu l=%fn\n',W11,L11);
fprintf(fid,'m12 x8 x8  vss vss nmos w=%fu l=%fn\n',W12,L12);
fprintf(fid,'m13 x6 x8  x7  vss nmos w=%fu l=%fn\n\n',W13,L13);

fprintf(fid,'*** RESISTORES ***\n');
fprintf(fid,'rs x7 vss %fk\n',R2);
fprintf(fid,'rz x0 x4  %fk\n\n',R1);

fprintf(fid,'*** CAPACITORES ***\n');
fprintf(fid,'cl x4 vss %fp\n',C1);
fprintf(fid,'cc x3 x0  %fp\n\n',C2);

fprintf(fid,'*** ANALISE ***\n');
fprintf(fid,'.option temp=27\n');
fprintf(fid,'.control\n');
fprintf(fid,'ac dec 5000 1 1e12\n');
fprintf(fid,'run\n');
fprintf(fid,'set color0=white\n');
fprintf(fid,'set color1=black\n');
fprintf(fid,'set color2=black\n');
fprintf(fid,'set xbrushwidth=2\n');
fprintf(fid,'plot 20*log10(v(x4))\n');
fprintf(fid,'op\n');
fprintf(fid,'print v(vdd)*i(vdd)\n');
fprintf(fid,'print @m01[id]\n');
fprintf(fid,'print @m02[id]\n');
fprintf(fid,'print @m03[id]\n');
fprintf(fid,'print @m04[id]\n');
fprintf(fid,'print @m05[id]\n');
fprintf(fid,'print @m06[id]\n');
fprintf(fid,'print @m07[id]\n');
fprintf(fid,'print @m08[id]\n');
fprintf(fid,'print @m09[id]\n');
fprintf(fid,'print @m10[id]\n');
fprintf(fid,'print @m11[id]\n');
fprintf(fid,'print @m12[id]\n');
fprintf(fid,'print @m13[id]\n');
fprintf(fid,'print @m01[vds]-@m01[vdsat]\n');
fprintf(fid,'print @m02[vds]-@m02[vdsat]\n');
fprintf(fid,'print @m03[vds]-@m03[vdsat]\n');
fprintf(fid,'print @m04[vds]-@m04[vdsat]\n');
fprintf(fid,'print @m05[vds]-@m05[vdsat]\n');
fprintf(fid,'print @m06[vds]-@m06[vdsat]\n');
fprintf(fid,'print @m07[vds]-@m07[vdsat]\n');
fprintf(fid,'print @m08[vds]-@m08[vdsat]\n');
fprintf(fid,'print @m09[vds]-@m09[vdsat]\n');
fprintf(fid,'print @m10[vds]-@m10[vdsat]\n');
fprintf(fid,'print @m11[vds]-@m11[vdsat]\n');
fprintf(fid,'print @m12[vds]-@m12[vdsat]\n');
fprintf(fid,'print @m13[vds]-@m13[vdsat]\n');
fprintf(fid,'print @m13[vds]-@m13[vdsat]\n');
fprintf(fid,'.endc\n\n');
fprintf(fid,'.end\n');

fclose(fid);