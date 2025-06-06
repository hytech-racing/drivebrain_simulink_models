function [Vx, perc_diff, using_front_vel] = estimateVx4Wheels(rpm_FL, rpm_FR, rpm_RL, rpm_RR, tire_radius, delta_rad, yawrate_rad_s, tr, brake_pedal)

    gearboxRatio = 11.83;
    
    rads_FL = rpm_FL * 0.10472;
    rads_FR = rpm_FR * 0.10472;

    rads_RL = rpm_RL * 0.10472;
    rads_RR = rpm_RR * 0.10472;
    
    Vx_fl_corner = rads_FL / gearboxRatio * cos(abs(delta_rad)) * tire_radius;
    Vx_fl = Vx_fl_corner - (yawrate_rad_s * (tr/2));
    
    Vx_fr_corner = rads_FR / gearboxRatio * cos(abs(delta_rad)) * tire_radius;
    Vx_fr = Vx_fr_corner + (yawrate_rad_s * (tr/2));

    Vx_rl_corner = rads_RL / gearboxRatio * tire_radius;
    Vx_rl = Vx_rl_corner - (yawrate_rad_s * (tr/2));
    
    Vx_rr_corner = rads_RR / gearboxRatio * tire_radius;
    Vx_rr = Vx_rr_corner + (yawrate_rad_s * (tr/2));
    

    
    

    if(brake_pedal > .05)
        Vx = (Vx_fl + Vx_fr)/2;
        using_front_vel = true
        if((Vx_fl + Vx_fr)/2 > 0)
            perc_diff = abs((Vx_fl - Vx_fr)/2) / ((Vx_fl + Vx_fr)/2) ;
        else
            perc_diff = 0;
        end
        
    else
        Vx = (Vx_rl + Vx_rr)/2;
        using_front_vel = false
        if((Vx_rl + Vx_rr)/2 > 0)
            perc_diff = abs((Vx_rl - Vx_rr)/2) / ((Vx_rl + Vx_rr)/2) ;
        else
            perc_diff = 0;
        end
    end
    
end

