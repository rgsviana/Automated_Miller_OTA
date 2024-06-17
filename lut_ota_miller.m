% LUT para projetar OTAs Miller

% Versão Otimizada

lut_loader

Vdd = 1.0;
Vds = Vdd/2;
P = 500e-9;
Cl = 1e-12;
W0 = 10;
L0 = 130;

L01 = L0*4;
L02 = L0*4;
L03 = L0*4;
L04 = L0*4;
L05 = L0*4;
L06 = L0*4;
L07 = L0*4;
L08 = L0*4;
L09 = L0*4;

gm_id01 = 25;
gm_id02 = 25;
gm_id03 = 25;
gm_id04 = 25;
gm_id05 = 25;
gm_id06 = 25;
gm_id07 = 25;
gm_id08 = 25;
gm_id09 = 25;

Ibias = P/(5*Vdd);

Id08 = 2*Ibias;
Id05 = 2*Ibias;
Id06 = Ibias;

Id01 = Id05/2;
Id02 = Id05/2;
Id03 = Id01;
Id04 = Id02;
Id07 = Id06;
Id09 = Id08;

gm07 = Id07*gm_id07;
fu = gm07/(2*pi*Cl);

id_w01 = lut_finder2('P','id_w','vds',Vds,'L',L01,'gmid',gm_id01,lut_n,lut_p);
W01 = 1e6*Id01./id_w01;
id_w02 = lut_finder2('P','id_w','vds',Vds,'L',L02,'gmid',gm_id02,lut_n,lut_p);
W02 = 1e6*Id02./id_w02;
id_w03 = lut_finder2('N','id_w','vds',Vds,'L',L03,'gmid',gm_id03,lut_n,lut_p);
W03 = 1e6*Id03./id_w03;
id_w04 = lut_finder2('N','id_w','vds',Vds,'L',L04,'gmid',gm_id04,lut_n,lut_p);
W04 = 1e6*Id04./id_w04;
id_w05 = lut_finder2('P','id_w','vds',Vds,'L',L05,'gmid',gm_id05,lut_n,lut_p);
W05 = 1e6*Id05./id_w05;
id_w06 = lut_finder2('P','id_w','vds',Vds,'L',L06,'gmid',gm_id06,lut_n,lut_p);
W06 = 1e6*Id06./id_w06;
id_w07 = lut_finder2('N','id_w','vds',Vds,'L',L07,'gmid',gm_id07,lut_n,lut_p);
W07 = 1e6*Id07./id_w07;
id_w08 = lut_finder2('P','id_w','vds',Vds,'L',L08,'gmid',gm_id08,lut_n,lut_p);
W08 = 1e6*Id08./id_w08;
id_w09 = lut_finder2('N','id_w','vds',Vds,'L',L09,'gmid',gm_id09,lut_n,lut_p);
W09 = 1e6*Id09./id_w09;

idiff = 1e6*Id09;

destino = 'ota_miller.cir';

fid = fopen(destino,'w');

fprintf(fid,'Miller Operational Transconductance Amplifier - OTA Miller\n\n');
fprintf(fid,'*** ARQUIVOS DE MODELO ***\n');
fprintf(fid,'.include nmos130nm.pm\n');
fprintf(fid,'.include pmos130nm.pm\n\n');

fprintf(fid,'*** FONTES ***\n');
fprintf(fid,'vdd vdd 0   dc %f\n',Vdd);
fprintf(fid,'vss vss 0   dc 0\n');
fprintf(fid,'vin vin 0   dc %f ac 1\n',Vdd/2);
fprintf(fid,'vip vip 0   dc %f\n',Vds);
fprintf(fid,'i1  x1  vss dc %fu\n\n',idiff);

fprintf(fid,'*** MOSFETS ***\n');
fprintf(fid,'*M  D  G   S   B\n'); 
fprintf(fid,'m01 x2 vin x5  x5  pmos w=%fu l=%fn\n',W01,L01);
fprintf(fid,'m02 x3 vip x5  x5  pmos w=%fu l=%fn\n',W02,L01);
fprintf(fid,'m03 x2 x2  vss vss nmos w=%fu l=%fn\n',W03,L03);
fprintf(fid,'m04 x3 x2  vss vss nmos w=%fu l=%fn\n',W04,L03);
fprintf(fid,'m05 x5 x1  vdd vdd pmos w=%fu l=%fn\n',W05,L05);
fprintf(fid,'m06 x4 x1  vdd vdd pmos w=%fu l=%fn\n',W06,L06);
fprintf(fid,'m07 x4 x3  vss vss nmos w=%fu l=%fn\n',W07,L07);
fprintf(fid,'m08 x1 x1  vdd vdd pmos w=%fu l=%fn\n\n',W08,L08);
% fprintf(fid,'m09 x1 x1  vss vss nmos w=%fu l=%fn\n\n',W09,L09);

fprintf(fid,'*** CAPACITORES ***\n');
fprintf(fid,'*cc x3 x4 2.5p\n\n');

fprintf(fid,'*** ANALISE ***\n');
fprintf(fid,'.option temp=27\n');
fprintf(fid,'.control\n');
fprintf(fid,'ac dec 5000 1 1e12\n');
fprintf(fid,'run\n');
fprintf(fid,'plot 20*log10(v(x4))\n');
fprintf(fid,'op\n');
fprintf(fid,'print v(vdd)*i(vdd)\n');
fprintf(fid','print @m01[vds]-@m01[vdsat]\n');
fprintf(fid','print @m02[vds]-@m02[vdsat]\n');
fprintf(fid','print @m03[vds]-@m03[vdsat]\n');
fprintf(fid','print @m04[vds]-@m04[vdsat]\n');
fprintf(fid','print @m05[vds]-@m05[vdsat]\n');
fprintf(fid','print @m06[vds]-@m06[vdsat]\n');
fprintf(fid','print @m07[vds]-@m07[vdsat]\n');
fprintf(fid','print @m08[vds]-@m08[vdsat]\n');
% fprintf(fid','print @m09[vds]-@m09[vdsat]\n');
fprintf(fid,'.endc\n\n');
fprintf(fid,'.end\n');

fclose(fid);