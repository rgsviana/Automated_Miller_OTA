vdspoints = 131;
vgspoints = 131;
total_par_number = 20;


%%% A STRUCT TEM UMA SUBESTRUTURA V QUE ARMAZENA OS VETORES PARA CADA VGS
%%% DIFERENTE (131 AO TODO).

for k=1:10 %% LENGTH SWEEP %%
    
    filename=strcat('outN_',num2str(k),'.txt');

    vecsize = vgspoints;
    
    data = textread(filename);
    data(:,6)=[];
    data(:,1)=[];
    data = reshape(data,vdspoints*vgspoints,total_par_number);
    
    lut_n(k).vgs = unique(0.001*round(1000.*data(:,6)));

    for m = 1:vgspoints %% VGS SWEEP %%

        
        lut_n(k).v(m).vds = data(vecsize*(m-1)+1:m*vecsize,1);
        lut_n(k).v(m).igs  = data(vecsize*(m-1)+1:m*vecsize,7);
        lut_n(k).v(m).gmbs = data(vecsize*(m-1)+1:m*vecsize,8);
        lut_n(k).v(m).cgs  = data(vecsize*(m-1)+1:m*vecsize,9);
        lut_n(k).v(m).cgb  = data(vecsize*(m-1)+1:m*vecsize,10);
        lut_n(k).v(m).id = data(vecsize*(m-1)+1:m*vecsize,12);
        lut_n(k).v(m).gds = data(vecsize*(m-1)+1:m*vecsize,13);
        lut_n(k).v(m).cgd = data(vecsize*(m-1)+1:m*vecsize,14);
        lut_n(k).v(m).cdd = data(vecsize*(m-1)+1:m*vecsize,15);
        lut_n(k).v(m).igd = data(vecsize*(m-1)+1:m*vecsize,16);
        lut_n(k).v(m).gm  = data(vecsize*(m-1)+1:m*vecsize,17);
        lut_n(k).v(m).cgg  = data(vecsize*(m-1)+1:m*vecsize,18);
        lut_n(k).v(m).cdg = data(vecsize*(m-1)+1:m*vecsize,19);
        lut_n(k).v(m).csg = data(vecsize*(m-1)+1:m*vecsize,20);
        lut_n(k).v(m).gmid = data(vecsize*(m-1)+1:m*vecsize,17)./(data(vecsize*(m-1)+1:m*vecsize,12)+1E-18);

    
    end

end

for k=1:10 %% LENGTH SWEEP %%
    
    filename=strcat('outP_',num2str(k),'.txt');

    vecsize = vgspoints;
    
    data = textread(filename);
    data(:,6)=[];
    data(:,1)=[];
    data = reshape(data,vdspoints*vgspoints,total_par_number);
    
    lut_p(k).vgs = unique(0.001*round(1000.*data(:,6)));

    for m = 1:vgspoints %% VGS SWEEP %%
        
        lut_p(k).v(m).vds = abs(data(vecsize*(m-1)+1:m*vecsize,1));
        lut_p(k).v(m).igs  = data(vecsize*(m-1)+1:m*vecsize,7);
        lut_p(k).v(m).gmbs = data(vecsize*(m-1)+1:m*vecsize,8);
        lut_p(k).v(m).cgs  = data(vecsize*(m-1)+1:m*vecsize,9);
        lut_p(k).v(m).cgb  = data(vecsize*(m-1)+1:m*vecsize,10);
        lut_p(k).v(m).id = data(vecsize*(m-1)+1:m*vecsize,12);
        lut_p(k).v(m).gds = data(vecsize*(m-1)+1:m*vecsize,13);
        lut_p(k).v(m).cgd = data(vecsize*(m-1)+1:m*vecsize,14);
        lut_p(k).v(m).cdd = data(vecsize*(m-1)+1:m*vecsize,15);
        lut_p(k).v(m).igd = data(vecsize*(m-1)+1:m*vecsize,16);
        lut_p(k).v(m).gm  = data(vecsize*(m-1)+1:m*vecsize,17);
        lut_p(k).v(m).cgg  = data(vecsize*(m-1)+1:m*vecsize,18);
        lut_p(k).v(m).cdg = data(vecsize*(m-1)+1:m*vecsize,19);
        lut_p(k).v(m).csg = data(vecsize*(m-1)+1:m*vecsize,20);
        lut_p(k).v(m).gmid = data(vecsize*(m-1)+1:m*vecsize,17)./(data(vecsize*(m-1)+1:m*vecsize,12)+1E-18);

    
    end

end

clearvars -except lut_n lut_p