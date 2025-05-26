function [Vx, perc_diff] = estimateVxTwoWheels(rpm_RL, rpm_RR, tire_radius, yawrate_rad_s, tr)

    gearboxRatio = 11.83;
    

    rads_RL = rpm_RL * 0.10472;
    rads_RR = rpm_RR * 0.10472;
    

    Vx_rl_corner = rads_RL / gearboxRatio * tire_radius;
    Vx_rl = Vx_rl_corner - (yawrate_rad_s * (tr/2));
    
    Vx_rr_corner = rads_RR / gearboxRatio * tire_radius;
    Vx_rr = Vx_rr_corner + (yawrate_rad_s * (tr/2));
    

    Vx = (Vx_rl + Vx_rr)/2;
    
    if((Vx_rl + Vx_rr)/2 > 0)
        perc_diff = abs((Vx_rl - Vx_rr)/2) / ((Vx_rl + Vx_rr)/2) ;
    else
        perc_diff = 0;
    end

end

