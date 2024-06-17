function [val_out,vgs_out] = matlab_script_2_lut_finder(nch,arg_out,arg1,val1,arg2,val2,arg3,val3,lut_n,lut_p)
%UNTITLED10 Summary of this function goes here
%   

vecsize = 131;

val_out=[];


if strcmp(nch,'N')
    lut=lut_n;
elseif strcmp(nch,'P')
    lut=lut_p;
else
    sprintf('Tipo de dispositivo inválido')
    return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% DEFAULT VALUES %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

vds_default = 0.65;
L_vec=130*(1:1:10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK GIVEN PARAMETERS %
%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%% CHANNEL LENGTH %%%%%
if strcmp(arg1,'L')
    L=val1;
elseif strcmp(arg2,'L')
    L=val2;
elseif strcmp(arg3,'L')
    L=val3;
else
    L=L_vec;
end

%%%%%%%%%% VDS %%%%%%%%%%
if strcmp(arg1,'vds')
    vds_in=val1;
elseif strcmp(arg2,'vds')
    vds_in=val2;
elseif strcmp(arg3,'vds')
    vds_in=val3;
else
    vds_in=vds_default;
end

% %%%%%%%%%% ID/W %%%%%%%%%%
% if strcmp(arg1,'id_w')
%     id_w_in=val1;
% elseif strcmp(arg2,'id_w')
%     id_w_in=val2;
% elseif strcmp(arg3,'id_w')
%     id_w_in=val3;
% else
%     id_w_in=vds_default;
% end

%%%%%%%%%% OTHER %%%%%%%%%%
if strcmp(arg1,'gmid')
    if ((val1>28)||(val1<2))
        sprintf('GM/ID out of rage!')
        return
    else    
        gmid_in=val1;
    end
elseif strcmp(arg2,'gmid')
    if ((val2>28)||(val2<2))
        sprintf('GM/ID out of rage!')
        return
    else    
        gmid_in=val2;
    end
elseif strcmp(arg3,'gmid')
    if ((val3>28)||(val3<2))
        sprintf('GM/ID out of rage!')
        return
    else    
        gmid_in=val3;
    end
else
    gmid_in=[];
end

if max(size(L))==1
    n=find(L_vec==L);

    for m = 1:vecsize
        
        igs(m)  = interp1(lut(n).v(m).vds,lut(n).v(m).igs,vds_in);
        gmbs(m) = interp1(lut(n).v(m).vds,lut(n).v(m).gmbs,vds_in);
        cgs(m)  = interp1(lut(n).v(m).vds,lut(n).v(m).cgs,vds_in);
        cgb(m)  = interp1(lut(n).v(m).vds,lut(n).v(m).cgb,vds_in);
        gm(m)   = interp1(lut(n).v(m).vds,lut(n).v(m).gm,vds_in);
        id(m)   = interp1(lut(n).v(m).vds,lut(n).v(m).id,vds_in);
        gds(m)  = interp1(lut(n).v(m).vds,lut(n).v(m).gds,vds_in);
        cgd(m)  = interp1(lut(n).v(m).vds,lut(n).v(m).cgd,vds_in);
        cdd(m)  = interp1(lut(n).v(m).vds,lut(n).v(m).cdd,vds_in);
        cgg(m)  = interp1(lut(n).v(m).vds,lut(n).v(m).cgg,vds_in);
        gdg(m)  = interp1(lut(n).v(m).vds,lut(n).v(m).cdg,vds_in);
        csg(m)  = interp1(lut(n).v(m).vds,lut(n).v(m).gmbs,vds_in);
        gmbs(m) = interp1(lut(n).v(m).vds,lut(n).v(m).csg,vds_in);
        gmid(m) = interp1(lut(n).v(m).vds,lut(n).v(m).gmid,vds_in);   
        
    end
else
    


    for n = 1:length(L)
        for m = 1:vecsize
        
            
            igs(m,n)  = interp1(lut(n).v(m).vds,lut(n).v(m).igs,vds_in);
            gmbs(m,n) = interp1(lut(n).v(m).vds,lut(n).v(m).gmbs,vds_in);
            cgs(m,n)  = interp1(lut(n).v(m).vds,lut(n).v(m).cgs,vds_in);
            cgb(m,n)  = interp1(lut(n).v(m).vds,lut(n).v(m).cgb,vds_in);
            gm(m,n)   = interp1(lut(n).v(m).vds,lut(n).v(m).gm,vds_in);
            id(m,n)   = interp1(lut(n).v(m).vds,lut(n).v(m).id,vds_in);
            gds(m,n)  = interp1(lut(n).v(m).vds,lut(n).v(m).gds,vds_in);
            cgd(m,n)  = interp1(lut(n).v(m).vds,lut(n).v(m).cgd,vds_in);
            cdd(m,n)  = interp1(lut(n).v(m).vds,lut(n).v(m).cdd,vds_in);
            cgg(m,n)  = interp1(lut(n).v(m).vds,lut(n).v(m).cgg,vds_in);
            gdg(m,n)  = interp1(lut(n).v(m).vds,lut(n).v(m).cdg,vds_in);
            csg(m,n)  = interp1(lut(n).v(m).vds,lut(n).v(m).gmbs,vds_in);
            gmbs(m,n) = interp1(lut(n).v(m).vds,lut(n).v(m).csg,vds_in);
            gmid(m,n) = interp1(lut(n).v(m).vds,lut(n).v(m).gmid,vds_in);
        
        
        end
    end
end

vgs_vec = lut(1).vgs(:);
id_w = id./10e-6;

%%%%%%%%%%%%%%%% FIND OUTPUT PARAMATERS IF GMID GIVEN %%%%%%%%%%%%%%%%%%%%%
if isempty(gmid_in)
   eval(strcat('val_out=',arg_out,';'));
else
   eval(strcat('val_out=interp1(gmid,',arg_out,',gmid_in);'));
   vgs_out = interp1(gmid,vgs_vec,gmid_in);
end



end

