function [ins_noise] = estimateINSNoise(ins_mode, vel_u, v_wheels, v_INS)
%ESTIMATEINSNOISE Summary of this function goes here
%   Detailed explanation goes here
ins_noise =0;
if(ins_mode ==0)
    ins_noise = 100;
elseif(ins_mode==1)
    ins_noise = abs(vel_u)*10;
elseif(ins_mode==2)
    ins_noise = abs(vel_u);
else
    ins_noise = 0.5;
end

if( (v_wheels > 0) && (v_INS < 0))
    ins_noise = 20;
end
end

